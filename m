Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F2EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41682084A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 14:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjZhHRpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeL3OiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 09:38:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35519 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeL3OiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 09:38:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so22153742ljb.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 06:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDsgFz43MC7gsQ3oqoVJjrlwfP7Ixawz8vWOyi4tdwU=;
        b=cjZhHRpg2+iYUDvDRZaugC3A9arpLTHzaj6GxmzKdTXHqDin3YGcYu1n92z/YgOcGz
         M2Oc0gjY8aZIZjW8LPs8nhboqolH1EIwjegujLieAQf6KSyoVeO9VbaXXA/ZXg8HVSQl
         5O8pYUj3drm6qQj0NbKl5LQJuFOsyy7CRkTQWlErsBF5U0xgL2YhxGkFgdzb/+qgmqYn
         Dk1v0IjkNzs4n4xXIKSlE0fs2whyIaj9HM85nhKzhi6DNX3c7VEgvyO91QfIaHz7buKz
         0gFfjjON3ThQpW6gkEXyxCBj47HIHP2wdRjnjauhJsVFcFZmkmvUDjFNSQ6C/A0cgm+y
         n5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDsgFz43MC7gsQ3oqoVJjrlwfP7Ixawz8vWOyi4tdwU=;
        b=jkEMYCXw4ypxIjtQhsq3EQXeRctl6WChJ2eiMzUtkuFUUejv3ly2k17XpdDIG+Wo1m
         keZiz0z+ChadugJFA9CybJk0Z58dtGLjhpGN36VeKsJjpztMQFiEqatpUvYXeExkjYK4
         /TtHUTaAhDZgN1bezNSb90gtyuY5wb+5Skkimyju0QWYKcGo0eh1suvbdRy2wKsHqm7J
         N7W+nxdQNWPAN4+D2mUs7Z44cg5EncMNC1Jhvl/67k8xVyqXqyodkCtTJhfb+KBePMZd
         R/fmqhv9GzyHwvbL1ET1Wnabgsn/9l003RUr+KuMqOstVtgggsyyaweibXyCDDRUntf0
         RVFw==
X-Gm-Message-State: AJcUukcWzsoyhsMB5R+Vcgo2dvzIYIUxm8QaFy0xZnqwxD1GVQRv+JBN
        wK3ejoN01eBOYeHBGL/jsE0=
X-Google-Smtp-Source: ALg8bN48GVUQpgDix5Q8UtVDqlWYTXhLUSz9betus6VrxfcWf3XMEpDBXQ2kUuHOcU3hLrOxD3KJ5A==
X-Received: by 2002:a2e:20c3:: with SMTP id g64-v6mr21811018lji.101.1546180684117;
        Sun, 30 Dec 2018 06:38:04 -0800 (PST)
Received: from Tarkus (95-165-173-36.static.spd-mgts.ru. [95.165.173.36])
        by smtp.gmail.com with ESMTPSA id d19-v6sm9623049ljc.37.2018.12.30.06.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 06:38:03 -0800 (PST)
Date:   Sun, 30 Dec 2018 17:37:43 +0300
From:   Ivan Krylov <krylov.r00t@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: pass filename to objdump via execl
Message-ID: <20181230173743.55b85189@Tarkus>
In-Reply-To: <20181014140451.GB24104@krava>
References: <20181014111803.5d83b806@Tarkus>
        <20181014140451.GB24104@krava>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Oct 2018 16:04:51 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> Acked-by: Jiri Olsa <jolsa@kernel.org>

Is there anything I could do to improve the patch? Should I wrap the
path to objdump executable in a similar way?

-- 
Best regards,
Ivan
