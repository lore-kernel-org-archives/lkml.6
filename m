Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ADEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A1A2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reyXCvAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A1A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeIZBDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:03:38 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:34410 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbeIZBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:03:37 -0400
Received: by mail-lf1-f53.google.com with SMTP id y10-v6so6770263lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ckvFWQMsj7g7FcYTFhC3rJQ4n8vIlWnxoHzlejBFc3k=;
        b=reyXCvAwd6s1Nl9WIuUtqk/jO6Q4Rzs7XxUmVtApCBg44hQC0rb5vr1RxT5DGIsW9T
         xgeiFYf0gVEnZJEQhegLY5Q66MoL9i+n9HCU4DsfugTGCU6JZnSejnMTuI6qgoISKkNU
         LSef5eUu/KNnzX+GcLAGUWlB1l3PPtQlRfSiLnNwiXMDv8ZQl3pWG2hx5BKB9dFdnVWC
         BjUgcAHKPT2SgprPJ44J9JTNay3ePV1s00rS1o2glP8bkFo3T9s0MC9yriiSZaN9Mevc
         2fBm/8wlLpkaV8LVgFmt1rut9RmFYOM+oVI2UMDdfs0FEdQ5T+jSsgcuE8C7cSoZ4a4n
         j9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ckvFWQMsj7g7FcYTFhC3rJQ4n8vIlWnxoHzlejBFc3k=;
        b=hnWmCY+ijnU3Rk8anbiPcd2FeffMNWflOFqnJBT2aUoQHVhLC+u3ncJT37hrMya3Pi
         N/Piz2sFX3+aMXKrwkiAa01545dwqYOAACo00wb5CpgT7kSGvxZWVqxYbOJqRHs0Relk
         aDBUMgqjn0imLbkqxg0QzZtUcQplbzpep6KvxpCRW+sEiYpfRhO2FhW0sdlRSR2wR29o
         xvVlHM+/KYFbQ6+CuF+W7cd3MYqnfdUP9oNOFfJ4vSF2hcERkMFAGQxMNeoGKwXQ502k
         UTYBbkdf5J6KNQCGavdIromfmzbXKiUtZaAPcf9v7rQxAlI4XkKpOFwzNQ2XUFxyD68Z
         Pa+A==
X-Gm-Message-State: ABuFfohpSnXjrVxmi9ZqVBjpxz5ZAy15ld2NRm3MGGfM7Fp3FnCZvTy2
        ulrLwihi5ZYqPLDwOKcAQu3fUOrFyqc=
X-Google-Smtp-Source: ACcGV63HOmwdfvUzogy72IjNxBy7BfoOPAl8PEaeWOoNi5Z/e3BJRuv1bZvHRcpnxaFa8cAcFD903w==
X-Received: by 2002:a19:974d:: with SMTP id z74-v6mr1859329lfd.17.1537901681446;
        Tue, 25 Sep 2018 11:54:41 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id j10-v6sm551475ljb.33.2018.09.25.11.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:54:40 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 484AD460678; Tue, 25 Sep 2018 21:54:40 +0300 (MSK)
Date:   Tue, 25 Sep 2018 21:54:40 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Tong Zhang <ztong@vt.edu>, tglx@linutronix.de,
        akpm@linux-foundation.org, linux@dominikbrodowski.net,
        ebiederm@xmission.com, keescook@chromium.org, Dave.Martin@arm.com,
        wolffhardt.schwabe@fau.de, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org, wenbo.s@samsung.com
Subject: Re: different capability from different namespace required for
 prctl_set_mm_exe_file
Message-ID: <20180925185440.GJ15710@uranus>
References: <990D0DB4-35C7-4B7B-A938-2B984CD97E78@vt.edu>
 <20180925173745.GA20508@kroah.com>
 <20180925183427.GH15710@uranus>
 <20180925184054.GA15291@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925184054.GA15291@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 08:40:54PM +0200, Greg KH wrote:
> > 
> > It is done this way on purpose. The prctl_set_mm_map is a complex call
> > which carries a bunch of parameters and allowed if you're inside user-ns admin,
> > in turn prctl_set_mm allows to modify settings one by one. So no, it is not
> > an error but rather call specifics.
> 
> I was hoping that when the submitter went to create such a patch, they
> would have realized that. You learn more when trying to fix a problem
> than when someone has to tell you the answers :)

True :) Next time I'll wait a couple of days.
