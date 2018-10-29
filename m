Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1325AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEEA2082B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeTLAKsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBEEA2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeJ3IZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:25:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38571 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3IZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:25:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2-v6so4100644wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tfOfXSsIppU7toG8W9UNMac4cH1s0TZf8mZTR3v16Ks=;
        b=GeTLAKsDJSJ71hbLC4mm3zXDhuTrDj1oU7eA+zkGiA5knBd7a9Q7b9j2wmNkjRrvps
         bTFqzE4Gv31ns2l5mP1LWBKTDCDs4hzyIfyXH65OwwHW23DrHm/OTqaELuVg1ranpMYc
         /aN+KiH3kW2fXBdvyPnP2EWvr8DBOtSTogK/GdNzpm+k01GRjTdMdYyetbp3iExxhIQM
         Iy5g/Q3lAjKK5BvVjPUnIYOH+vxzCvj/bZq9GKbAemQf8C6g4Z7f54h618Cof3JV2rGD
         ewQDZDGwxy4e7+vTP6uOF8BdPXeH3jD7oOtQj+VNpzGX7Ty/aRlWptvQmFreVlIEhSr4
         BVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tfOfXSsIppU7toG8W9UNMac4cH1s0TZf8mZTR3v16Ks=;
        b=pAeh/HyWtI4aDLC+LvDVKIxwRIcMz/lY3bxzijfFOZ8TDWWbay7AJN6Kb5IqtmehFi
         7Vnc8jsQItpdtF0DCA2R/5kR4I9fZCWGKNiEJxeMb1dHn3P6oTitBZr9pMt2o6z3jtQh
         pFM7jpV+NEXrXngi5qv/mxen/vs3d2bd1pq40a/PIr0em57Rx4gEEx0GJ0vqmdNNIbWI
         7Oh3RBjZx7POW6JTqKGfg0ARJGY1ICsQgVPPmnGD84+KRnV4tA6OzqXo3oUqsFwPuWoa
         hF3EnB6tsBsCSXGV3VsdKPW4BOvyOR2x52B9spwqPufHujFBWMxpDPJo0yrvtyeyPqJA
         1X+Q==
X-Gm-Message-State: AGRZ1gJ+OjABbbyMiDmVmtl+zpGB2vBwgMEtxvXMGhx9SWsYQx4DOd+W
        VCEvPW4isIKJgWofG3uyxg==
X-Google-Smtp-Source: AJdET5es1jHJ3uyXPuE8JFTEkmTOsMu9ZYwkUyf2bx97v8m0Y47wlNzXG+Ebek5K1AaVSkN9c3MJTQ==
X-Received: by 2002:a7b:c24f:: with SMTP id b15-v6mr3715159wmj.36.1540856057730;
        Mon, 29 Oct 2018 16:34:17 -0700 (PDT)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id t82-v6sm13683928wme.30.2018.10.29.16.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 16:34:16 -0700 (PDT)
Date:   Tue, 30 Oct 2018 02:34:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dancol@google.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181029233414.GA29750@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd much rather move to a model in which userspace *explicitly* tells
> the kernel which fields it wants, with the kernel replying with just
> those particular fields, maybe in their raw binary representations.
> The ASCII-text bag-of-everything files would remain available for
> ad-hoc and non-performance critical use, but programs that cared about
> performance would have an efficient bypass. One concrete approach is
> to let users open up today's proc files and, instead of read(2)ing a
> text blob, use an ioctl to retrieve specified and targeted information
> of the sort that would normally be encoded in the text blob. Because
> callers would open the same file when using either the text or binary
> interfaces, little would have to change, and it'd be easy to implement
> fallbacks when a particular system doesn't support a particular
> fast-path ioctl.

You've just reinvented systems calls.

I suspect the DB in question cares about CPU related numbers and nothing
else which can be nicely split from the rest of /proc/stat.
