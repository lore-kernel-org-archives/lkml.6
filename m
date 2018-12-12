Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCDC65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5B42080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 16:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEr/YZQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5B42080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbeLLQF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:05:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:34021 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeLLQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 11:05:59 -0500
Received: by mail-it1-f193.google.com with SMTP id x124so14001005itd.1;
        Wed, 12 Dec 2018 08:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66QPTQ7+cq7bOIJyB6+3dn9pUq+R8OmhqN3Jn9ivvDY=;
        b=lEr/YZQgaX4fXH81+cTgdAPE36nEjqewQqsa/rOeSHo3At/I8OFbylyjgGiVoav6tx
         PS87w/GrZlVrE2ZdTOkXLxp6u+jZwP/nFZPY6vrg7MI6igp3QVuyGdTpl0VmXuvSUPVs
         EB7e8FsV+gmM8eN+sECKXcVplya98JzVGSlkLlVcZSrd4JXswsJTWjIacfc9PlPTwtAN
         IPSkMmDFEMaoTWBHi6T0w1Lqb/cSMiN2RCRyc6jTpQHTbO/y2DYp0yZXCKvMd3MNXRe8
         JF1LsMzMMj1/xd59cTxRy9UhoxM9awjFAsP7jAOnmODJhQcB45FCzdtbugOzRrgtVzeZ
         xSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66QPTQ7+cq7bOIJyB6+3dn9pUq+R8OmhqN3Jn9ivvDY=;
        b=B7QSzKbBiGF1WhqBvSXhs1wD11KkBTJVnQ//PAACEwK98YctV2S/2tpBwPkZjxyjvm
         VJHtCJAVUC/bmucBf9OwyK1AgqmgQ5Rer1Qei0fc5LOTuUxPZpz8A5CWlp4+JfcK4Z4I
         +Xe35N0625BRlSAqakUu43bBEU9szOGiSx+0D6yPx7gjVYufW9a0EV9YfZ40i7hbvPgt
         erNFwVoR+VfCDBfBTOMT1xukbDvewgdt+0R+Ev6ETrtx33C+oq9el3naQR4575axd0Yh
         gzux1vAlFVMTzOs2qx0HeXAdSq3/xAPSDPfXei+lFnvti7bhILaChr/FEfAxLPoB/16P
         8MYg==
X-Gm-Message-State: AA+aEWYk2wataeKzD+cNtDRz1WllcgslZFiIA0NK1liCmsVVKoAY3Mpf
        JPVMwIztP2K9FM/9RT7/iRqr/RlZpEiOYSVHXK0=
X-Google-Smtp-Source: AFSGD/WAePen4Mgrqtd6dln0ZD02zbLHSB3l63r9nWQsa0MCsi71KP0LVaouyhXJT5YRn0gjBtRcJNyVAt5eL8tPmBk=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr6147424itc.37.1544630758099;
 Wed, 12 Dec 2018 08:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20181212160145.23117-1-tiny.windzz@gmail.com>
In-Reply-To: <20181212160145.23117-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Thu, 13 Dec 2018 00:05:47 +0800
Message-ID: <CAEExFWuoJZfHeVemcLz9JhrQ_RBMzjsB3CopymBMWhEyWVR=rA@mail.gmail.com>
Subject: Re: [PATCH] serial/sunsu: fix refcount leak
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jslaby@suse.com,
        sparclinux@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for got to add a prefix(PATCH v2).
I hope this has no effect.

MBR,
Yangtao
