Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB71C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36D120989
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E76DYkUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfA0TpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:45:14 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:41227 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfA0TpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 14:45:13 -0500
Received: by mail-qk1-f169.google.com with SMTP id 189so8285976qkj.8;
        Sun, 27 Jan 2019 11:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=E76DYkUpBgoSUAnJJ71Pf0zW0Chwh0q/XSVXNBBj2OINwX3sEuI5dxZe6RkVUU+BIh
         hxUc8nwFqgWWlMNgRDmH0TKianKZP1Rr9RNyIM8wjEFGoW8aVhSyq6XlZPSMl+z6reAj
         y6pklOe5P/3Bnhwbn9vB8S6MKN0P3MZ4OQ9vRWjU2JkIkcfq/QTWRjvTq03MSS+xaqE3
         tN50mkCpEVyImWcfrFH55loCq/h6Rn8sZnFdSkkYLu9g5mPD5immkm6uUjT+BojUbBQB
         D+BPS6R2+V43f7G7/udGlTFPVxwelqCDjpzoPUzOEzeeNxITBD9YqUmQlZvoridzOiWK
         B5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PtDh65laPAWJavv9wp5KFeO9mCKsj9rNTLxlkFhGhZiX7dbfrPuffcDnSnrzAOOAhO
         PMyqX+EmvZvDTkyEf/8ng7/Z6OACee00bn5bEjmEuAbB/VIhKxJgu9KDqgF3Czce4dGy
         MIaj4hd0mOJFfiY2o1rOz7MBM91f3aJ7W7b5c9z3hWugZqeid1fi9CqjGQrrjlPqGacL
         +bc0yX6+f8bVexKd5zSN9cyL54apdN4mmYSUaR2T95uWfYgD074O2YAqGEjAQvNrTrX+
         Kb/7ANaOUezVyUBoe+a97e+vQLFetYst6InwPL/SFO7QEIwJZRTc9JvBpoQL8yq6SQ+u
         XyjQ==
X-Gm-Message-State: AJcUukc+8UPsj/IPe8QpsxIStPfT9BMcpv2QIY9v0Wl+j3pYrjjpVMKD
        gYBQe/UdpKICnXbgRrVEzC8=
X-Google-Smtp-Source: ALg8bN4/f9YqNM6OxXF7W99OWoIoo2oOFX7savAgfQeDNQmOxE7z3lSSCXu5mM8hXIAyMyTv/gM54w==
X-Received: by 2002:ae9:dec5:: with SMTP id s188mr17025961qkf.127.1548618312547;
        Sun, 27 Jan 2019 11:45:12 -0800 (PST)
Received: from renatolg ([186.220.19.121])
        by smtp.gmail.com with ESMTPSA id d79sm21506496qkg.56.2019.01.27.11.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 11:45:12 -0800 (PST)
Date:   Sun, 27 Jan 2019 17:45:01 -0200
From:   Renato Lui Geh <renatogeh@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 0/2] staging: iio: ad7780: move out of staging
Message-ID: <20190127194452.nkewca2dbvkf5ez6@renatolg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

