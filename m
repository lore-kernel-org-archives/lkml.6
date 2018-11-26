Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48BAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8796320672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 06:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+tLXO9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8796320672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeKZRwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 12:52:06 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:34833 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeKZRwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 12:52:06 -0500
Received: by mail-pf1-f169.google.com with SMTP id z9so6108627pfi.2;
        Sun, 25 Nov 2018 22:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cMSvfZ8r8zhMKFg6SzgErJzy7EJ2SJ5yF8QA8WrTDpk=;
        b=r+tLXO9xuNrSJWXWll+UQEtTWZO7Cg6CxspQegmNMYfcbSqHylW7SFD70yI79pzR5n
         4u5U1yb2TIiwZnwLqTb9hoLBWdvK1A3KnktDRpskcRu0cVpkfgSMIfz+XB0m88vmYq7n
         Q4WJwQ1Ry3GBuRR5607sNUg15/WOsCp7PCBtrSY6VCBxG6j+PHhMw0FWFh+9COkxfWKO
         iXMqerIC7AgAG5vNc5bFKAnME49shctXUnXdoqI5QmhV3hIiieJ1QDlVqJafiHUKwiWG
         rgKp3jl4dFSxBRbeNTbfVrEvyMjvxcl0JKFl8CuP4Q037sszUhjFdGeZ7joRzTvlqHf5
         me6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cMSvfZ8r8zhMKFg6SzgErJzy7EJ2SJ5yF8QA8WrTDpk=;
        b=KswgUQ5Tcz0WMIOczkSWC/2jjK7e31eCTEj4pK+uFcfl3jb4YvzU8oCaJ9Y0F2BAZp
         YysOeeiaSP/F99PXoJ1DVtIqAdMtSe2dFurhAWA1IrF8QdeslyydvYy9ICIQU8Bfr13/
         dJP4DDAmjL3zFAfuchBLWKA7n+24WxKA8NZ4+SqiBaboMe1BTx0zdwPB9G/FpM2g6wx1
         tkK/Nn0uXkJor3N8O46ty4VoP3pNonnogkpwA2DiqPNhi9liIvPQfYMJ4DBfqAR1AoJy
         3QbikA9UgFz8HAqw7A8sMnzSIf23QH7oKAx9y/HpNL6xw2sIpbqVMzkxM1E0OUe5rwLo
         +bzw==
X-Gm-Message-State: AGRZ1gL6HYcrs6vKRfjqxLJVaqXj2VFvCH8fNPp2wR9ZiTj+lpnVVYOy
        Ot61/RkRQZotwD30agvu9M5jcv8UqdI=
X-Google-Smtp-Source: AJdET5cwLhbQFo/LBIrsGq4bnghXKDCrdWA+mm4Js28PhttDhtN45yKdSu5SVyYPawBrhD2wAu81Jw==
X-Received: by 2002:a62:8893:: with SMTP id l141mr26211560pfd.1.1543215537242;
        Sun, 25 Nov 2018 22:58:57 -0800 (PST)
Received: from leo.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d3sm85688780pgl.64.2018.11.25.22.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 22:58:56 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:58:46 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Sukumar Gopalakrishnan <sukumarg1973@gmail.com>
Cc:     davem@davemloft.net, karn@ka9q.net, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: hard-coded limit on unresolved multicast route cache in
 ipv4/ipmr.c causes slow, unreliable creation of multicast routes on busy
 networks
Message-ID: <20181126065845.GS24677@leo.usersys.redhat.com>
References: <147f730b-8cbf-b76d-f693-b3fdaf72a89c@ka9q.net>
 <20180721.220309.1193443933653884021.davem@davemloft.net>
 <20181120092321.GR24677@leo.usersys.redhat.com>
 <CADiZnkSy=rFq5xLs6RcgJDihQ1Vwo2WBBY9Fi_5jOHr8XupukQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADiZnkSy=rFq5xLs6RcgJDihQ1Vwo2WBBY9Fi_5jOHr8XupukQ@mail.gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 10:44:49AM +0530, Sukumar Gopalakrishnan wrote:
> Hi,
> 
>  There is a patch to make this queue len configurable. Is below mentioned going
> to be applied ?
> 
> http://lkml.iu.edu/hypermail/linux/kernel/1810.3/02344.html

Thanks for this reminder, I saw Stephen has gave some comments. But I'm not sure
which patch David would apply.

Thanks
Hangbin
