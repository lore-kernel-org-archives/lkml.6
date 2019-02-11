Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5A1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB2920811
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 07:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQXX5IB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBKHnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 02:43:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37461 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBKHnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 02:43:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so4935850plr.4;
        Sun, 10 Feb 2019 23:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LzdxB19zhApMwZH0H6vEn1LPmCbo2CeSOy3HttPM3Rk=;
        b=vQXX5IB20a2Re4fUEbSuRpgaZX4KGwVOHSTJWplqnNZf+8Y7r/l1ONh6IHkDNA/Hdk
         z4jy8vmTkP0N8GPyswCSk7dZkh4GpRNyvSP+7GFwGQ3NB1CwAUCKztvNaS37l+aTRjE9
         XGRKCtF/TDhLHml8qClvXaoORE2FZvSgzDJ+RB/xyyo53aT24zEsbPs3i/bBcVqpouO5
         mHRXz8GLZfJSYshQLLWnsIob2pZSHLkbzbpPlPUXA0yg2OITeDEpXfInkfKtTcnZxDs4
         vVBOpFe+QLlo5RH60Dae8kxggrxrtJ7c/qrPDyvObgEkLDnc5bAGcXiogTGN8FR7mzNz
         l30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LzdxB19zhApMwZH0H6vEn1LPmCbo2CeSOy3HttPM3Rk=;
        b=b0/s5BJrlOvveJMTYl5P5eQU7k+q7Sa18p+vpL+qbVRB6rtsa5JHepzNAQKCgZw+yA
         fX3HcdgLPah9bql50SO1Iqm+lybBOzSdbtRjxtw9c81uNAciqXP+qCutRigokMFKBb81
         gjT1y7nViOyUHblYenOtHTs5Q2dLPl8hNwGOGygHCQise24HAf7j+itPc4azEpYrXpJC
         AKMh4kuF+xz0c51AG/hFoi28Nm0eP9iKP5uUa0N8XH+OUV2dwo3WF4+lwkNCc83OFgB2
         xl9fAvjPOabec2Ud4iiSTeDL47BlqzuCTbLu2uJ98oWzoGcEu3g/gy4CYhm0Ih2vST4o
         0H9Q==
X-Gm-Message-State: AHQUAuat3Dr3PIvsgQeYAWaAH7CIUdeiOcJvS+bne4S88SbhjIAmTDxz
        dLDhOq0AqyyAFzZfChaKw34=
X-Google-Smtp-Source: AHgI3Iaf1MpBbJJ8uTMAYdhLdQxO4kI5hHbwP4MylJcKIuOLER1MTDBVTSxWgqEvQA/FP/c65uS2YA==
X-Received: by 2002:a17:902:2bc9:: with SMTP id l67mr1863808plb.241.1549870996468;
        Sun, 10 Feb 2019 23:43:16 -0800 (PST)
Received: from localhost ([175.223.48.87])
        by smtp.gmail.com with ESMTPSA id a90sm17164079pfj.109.2019.02.10.23.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Feb 2019 23:43:15 -0800 (PST)
Date:   Mon, 11 Feb 2019 16:43:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] Documentation: fix vm/slub.rst warning
Message-ID: <20190211074312.GA26364@jagdpanzerIV>
References: <1e992162-c4ac-fe4e-f1b0-d8a16a51d5e7@infradead.org>
 <20190211073537.GA25868@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211073537.GA25868@rapoport-lnx>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/11/19 09:35), Mike Rapoport wrote:
> On Sun, Feb 10, 2019 at 10:34:11PM -0800, Randy Dunlap wrote:
> > From: Randy Dunlap <rdunlap@infradead.org>
> > 
> > Fix markup warning by quoting the '*' character with a backslash.
> > 
> > Documentation/vm/slub.rst:71: WARNING: Inline emphasis start-string without end-string.
> > 
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Christoph Lameter <cl@linux.com>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> 
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
