Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1735C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFBB20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRcCE+qD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFBB20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIKVjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:39:06 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36869 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeIKVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:39:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id x83-v6so9469912ywd.4;
        Tue, 11 Sep 2018 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mc6tOkuEOaj9Zh5z+Qi2URABCfOvvhaoSifsIaaA/5U=;
        b=DRcCE+qDeSUfBoY+hq+avhI/cSpZ5nZNK9XXdIBsBSC4Ox//G2Ezuf37ipENEnm77x
         PnmVp8xTx/0BumxXdMHH6g5r3HBCMuKtIHDeyQLF7ofYkSNRe5QnBYzRhSEbYlOEEuzG
         F7/EJ0Xo+soNr73f602pc4Qk4KODXIvxwQ1chCqG+DxqlZmf0zA1UuXXdnL0x1v/YdnW
         B1a8A9KdAyCOclfn92YVXCKSnqxZnXDF8Ddxj93m1C9EO2PFcWY2/MSUkPAo8FuwiTUI
         MzVM0DDNCIlPJt5l174CdRX0Hy1C8ISIqvhSwpZE7ekgEKrBoagbe/rPkCNF9/XTVw5O
         czmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mc6tOkuEOaj9Zh5z+Qi2URABCfOvvhaoSifsIaaA/5U=;
        b=jjMLp0WCcWQt3grOWV+VHUpllBT18gg0J/sZUuKm6CxqjWJjZgBG6I2e9/IxkkeP/e
         mlNt03EdgBBTP3PzkKaVa3jSoFZ+EGuAtPF/pBJcLlZ0pPazTdAtKgdQz5v8IDJDN1zO
         2wLBbCRRZ1jDHtfbo13rNgDF2XdQBCvDAJefKBSD9WLlFPqHXqG2njSj5kKq/NCWSAv+
         NP7IvZui9y3ZC2pphKkiCaGYWnkhwHaiwNJcQKT0j/MBlLwpzOrr2jyHinWuvYLzsTwc
         gl8IXF3rm+ZOoufsUFfedZspyDBXhHBGz4X2bt0A09NTvQS7cRJaJR9ktanlOrW5AkQD
         Eu7Q==
X-Gm-Message-State: APzg51AIiE+vpPK/FPip4aEH92/O8od9EjQwRRWulrvTfonmL3Kk2+6C
        aHeaJiyud+M0Pn7HNvMeJog=
X-Google-Smtp-Source: ANB0VdaweDNCW3+BF9Bkp8uTJyV4rEfERinCWC/dnj14Wj3a3VOAo9HNr3zVkYa+FBDlPytwMKRQNA==
X-Received: by 2002:a81:ae4a:: with SMTP id g10-v6mr12619546ywk.2.1536683939261;
        Tue, 11 Sep 2018 09:38:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id 203-v6sm6723315ywv.34.2018.09.11.09.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:38:58 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:38:56 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911163856.GB2966370@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <20180910164920.GE1100574@devbig004.ftw2.facebook.com>
 <20180911000049.GB30977@ming.t460p>
 <20180911134836.GG1100574@devbig004.ftw2.facebook.com>
 <20180911154540.GA10082@ming.t460p>
 <20180911154959.GI1100574@devbig004.ftw2.facebook.com>
 <20180911160532.GB10082@ming.t460p>
 <20180911163032.GA2966370@devbig004.ftw2.facebook.com>
 <20180911163443.GD10082@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911163443.GD10082@ming.t460p>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ming.

On Wed, Sep 12, 2018 at 12:34:44AM +0800, Ming Lei wrote:
> > Why aren't switch_to_atomic/percpu enough?
> 
> The blk-mq's use case is this _reinit is done on one refcount which was
> killed via percpu_ref_kill(), so the DEAD flag has to be cleared.

If you killed and waited until kill finished, you should be able to
re-init.  Is it that you want to kill but abort killing in some cases?
How do you then handle the race against release?  Can you please
describe the exact usage you have on mind?

Thanks.

-- 
tejun
