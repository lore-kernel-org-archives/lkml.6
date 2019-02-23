Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A2EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD7520855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 20:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tcgSJ2c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfBWUC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:02:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38299 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfBWUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 15:02:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id n125so2643494pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 12:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4rS5Q4lRBXxjkTcaHBNRQjBPDbNeYTBiuu6ZmjbrLh8=;
        b=tcgSJ2c2x3T7YhKINThTB8R8goH36mYE8gv1+4HBpfHE0eui4XXRcY075oCpZdfpHd
         uMIJeio1kOHYocDaqm7gX+dj4EzISBQe6d0Vwz9NLlr4+XHbZdyWykieHID16VRllZwl
         moPyvHnxBQgcu31egsmnwQYIAYqElDcV0gQ1OLuCUfYhEpkKh0Z9Jh3+10aiUe0k+mso
         60s31ZWeWg/pTmjy/zNyxHqXvW9xD4SkWje14KCHZmiRMuxH5/aeyhx5rRURoLvEsiS7
         RssVc9GDUe/ph95KIRj1KkbI6kg6BWtIvqdooIDiKls7xr1TNMFN4/23ZupgRpLWbGYP
         hpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4rS5Q4lRBXxjkTcaHBNRQjBPDbNeYTBiuu6ZmjbrLh8=;
        b=jGix5h1vhELwKY04zs+xzkfXNgvVTeX+XJDyzvgoWxoJU7182LU43SWSaoyfLPlr4V
         x9urFMEVjw2SO9d0fH7oyHBEuQ3Etrqz2N7RpbcxNRDBSEY0hZ6RNm2Yq/+vMM5bokwO
         LTt8FIKDCq/R0LOIiOXP6z9mNfKVI51cmb0RRZ78FnX0O4D88YjJbQLXk0jLNnp179xf
         oBSjVxFubgE3rmzrVrocv286crBvJWFY+rEoNR7gIYk9eUeyn6b49B7C+zAno+qFJiwa
         5rBms3nCQj5kyLOr22AqS95Ch1+C9v1Y3/cFhvVW4JC7ssIDonoN/ETpd6yNsiydXOIh
         Qqeg==
X-Gm-Message-State: AHQUAuaEwX0wInvb9C1ozcgIw99AGrraL6lnbACgNAjCxqVqwLNc8vXE
        Ac3LYG56bEnzrTaggd0d6sc=
X-Google-Smtp-Source: AHgI3IYL8h9r4pMHykFl36jlFwMlmLCA5wmmsTk/jaI7dpBMv6ysCAnnySjOWhmlnp6cB0/ju+IKsg==
X-Received: by 2002:a65:468f:: with SMTP id h15mr10288800pgr.391.1550952147644;
        Sat, 23 Feb 2019 12:02:27 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id l28sm10475514pfi.178.2019.02.23.12.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 12:02:27 -0800 (PST)
Date:   Sun, 24 Feb 2019 01:32:20 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        w.d.hubbs@gmail.com, chris@the-brannons.com, kirk@reisers.ca,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: speakup: Replace simple_strtoul with kstrtoul
Message-ID: <20190223200220.GA3573@bharath12345-Inspiron-5559>
References: <20190223193121.GA4402@bharath12345-Inspiron-5559>
 <20190223193750.2yd3qiyr6q3wx463@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223193750.2yd3qiyr6q3wx463@function>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 08:37:50PM +0100, Samuel Thibault wrote:
> Bharath Vedartham, le dim. 24 févr. 2019 01:01:21 +0530, a ecrit:
> > simple_strtoul is obsolete. Change it to kstrtoul. Kernel is building
> > and booting successfully.
> 
> Please recheck your patch, temp is used after the simple_strtoul call.
> 
> Samuel

Sorry about that. After some thought, I feel this is a special case in
replacing simple_strtoul to kstrtoul. simple_strtoul can give back a
pointer to the end of the parsed string, whereas kstrtoul does not
give any thing of that kind. In our case, temp is the end of the
parsed cp string. 

To replace simple_strtoul to kstrtoul, we need to know the length of the
unsigned long int returned and shift the cp pointer by that length to
get temp. This might involve a bit of code refactoring.

Bharath
