Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B9C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FF820849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 09:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGY3Pamg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39FF820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbeLMJ2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 04:28:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43108 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbeLMJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 04:28:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so782695plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 01:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ocyKvlNoSQ08slyB9AmQUkfcLXgrDT6ojCqDcEL4Vg=;
        b=TGY3PamgIctgPKyDl/iy+VSoFtHYjj0++2pi6AHmJQjiIkkZoYAIbPzOdJDszIzz6H
         2XBpa2VxMfMUTbdqEKLBXcF1zJqpm0s1cUaKoEpEQTJwk+2OX3F80DSCgatIRXLa0Uym
         2RK3KksubPHtUS3dJbJkU9Hc6tv8jDZEsU5VK6y1pSYhmVCQnmWCni6J6KxR749NVe1Z
         LDxobq02g2u0sH5F+G8+fJtvv0kQY5pd85bjyWNPoATobg4u62O1PmjiwMBJOJshxQxY
         cOX5XkrWGkK6gqhgckTryWNoNqQVVQBlo46VeErgIH0j9cdMRJ5mjibLZFX+teZD7T4t
         AqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ocyKvlNoSQ08slyB9AmQUkfcLXgrDT6ojCqDcEL4Vg=;
        b=XNkKXK44m+fk8kXuVVDtEPYk/7TgiNSakzQ5RHaPoRcrMcSGcZPZQYlsxZQ/Mrdl2W
         U2gyc4hTOn8OrIPCJYET0RREsgpHknh6ocXmr++4hNxjNoCyr0mO+lj2+jtTJUDWEOZ7
         Aaal6Irh0OpD+uIcMmMqSF2JO4JcYruA35nF2xu4eLTKb6Ro/GR5NrviVUKIFJKGYaKp
         HqvdZzRnlBzncQZ4ZKKAKWy+6HGZGlc8w02qiexR8PLv8RizFEsVmXg5f4XyfAqj33In
         W3rzgNPleQug0C68bK//FJ8AhCOoFhdJHy6DbqJAUPp3XcqZ4fJqEKhAdIaNwJvi1MDb
         nXww==
X-Gm-Message-State: AA+aEWahqb+r/h1c1vI/ttL15Esbp/jOmc+OUSGp1xgND5A8z18PZmaU
        2oRB+tfDeF4GdGq4n9FY0bg=
X-Google-Smtp-Source: AFSGD/WdBwbIz5XohAxwhWrdtzOB2WFsYGWGjEVhHfFFFJLiPci+CCUvWBIiKv+WDYjhF83GGaS47Q==
X-Received: by 2002:a17:902:6ac5:: with SMTP id i5mr23135145plt.134.1544693296064;
        Thu, 13 Dec 2018 01:28:16 -0800 (PST)
Received: from localhost ([110.70.59.213])
        by smtp.gmail.com with ESMTPSA id o1sm2376029pgn.63.2018.12.13.01.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 01:28:15 -0800 (PST)
Date:   Thu, 13 Dec 2018 18:28:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 1/2] debugobjects: Warn wrong annotation outside bucket
 lock
Message-ID: <20181213092811.GA550@jagdpanzerIV>
References: <20181213043447.23006-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213043447.23006-1-dima@arista.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/13/18 04:34), Dmitry Safonov wrote:
> printk() may defer work to workqueue, and realization of workqueues
> uses debugobjects.

Sorry, not following. You mean per-CPU irq_work which printk_deferred()
is using? That one should not deal with debugobjects.

	-ss
