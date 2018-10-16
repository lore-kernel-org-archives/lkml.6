Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C05C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299532083E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CKSc2y34";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ISC1nSpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299532083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeJPLxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 07:53:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51694 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPLxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 07:53:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4915F60BFA; Tue, 16 Oct 2018 04:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539662701;
        bh=PSJrWXOaHBq6myX08lDVA31+ExmRcoUrsl930KP/+pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CKSc2y34ubGUPLPgqy6HVCYGL/DDlr0oGjH22Fvl2DaNsmArk3ZM341OpYVnvuqzC
         TdF0klHwRQm2IiVBHNwGIqn7vFrYhcAmCjDwL8uxdCZWM/9Uaosc4KH4C9N2lxnpve
         vwllr7l7oPZnn1G+vUbsb75OLtQ2S7N8+CHGEXD8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id C827D604BE;
        Tue, 16 Oct 2018 04:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539662700;
        bh=PSJrWXOaHBq6myX08lDVA31+ExmRcoUrsl930KP/+pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ISC1nSpKTEwfc2dOUvSIfeEuOmnsJ0oX7tM43EWwof8mMeNOJIeGmLN5it0mfcry9
         3fwZ6wheoSA2nuuJM3wjxjaFI9LeIutLSkl7wKHl1HC16TeAA7zrlPd1g9imm9UqJv
         CEBKO7X7Kyk/5yn7jvD6sdwTVTWxgopm6QnHjPS0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Oct 2018 12:05:00 +0800
From:   cang@codeaurora.org
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     dianders@chromium.org, subhashj@codeaurora.org,
        asutoshd@codeaurora.org, vivek.gautam@codeaurora.org,
        evgreen@chromium.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] scsi: ufs: make UFS Tx lane1 clock optional for
 QCOM platforms
In-Reply-To: <yq1ftx6wqeh.fsf@oracle.com>
References: <1539397502-30120-1-git-send-email-cang@codeaurora.org>
 <yq1ftx6wqeh.fsf@oracle.com>
Message-ID: <98938b7462e2a90e1b2089d6c6706c52@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 2018-10-16 10:56, Martin K. Petersen wrote:
> Can,
> 
>> Per Qcom's UFS host controller HW design, the UFS Tx lane1 clock could
>> be muxed with Tx lane0 clock, hence keep Tx lane1 clock optional by
>> ignoring it if it is not provided in device tree. This change also
>> performs some cleanup to lanes per direction checks when
>> enable/disable lane clocks just for symmetry.
> 
> Applied to 4.20/scsi-queue, thanks!

Thanks a lot!

-Can Guo
