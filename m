Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01290C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921B02083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IVzEOSl7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IVzEOSl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921B02083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755929AbeFSHRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:17:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54976 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755463AbeFSHRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:17:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DCB496060A; Tue, 19 Jun 2018 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529392661;
        bh=MjC/VlLdnVNsSZo2uNrjixUnPH/l3RZM0zaknI6rBu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IVzEOSl7KE85KUoRNqxYxKtOyfQSwZ5UL55AmUc72X/R6M8PPOrolEBKdMtQBz1Pi
         xxQmwOUJulp+3AOAD1vTjOaT5HZ9kw1v1WXbaqqCl6nHEZ/OMih2Q5pJEELGbCTNLA
         hhmjrvfTEgYZ/4H9D2ZDOQQYrS6m1JlMynm5sWzk=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 7948A604D4;
        Tue, 19 Jun 2018 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529392661;
        bh=MjC/VlLdnVNsSZo2uNrjixUnPH/l3RZM0zaknI6rBu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IVzEOSl7KE85KUoRNqxYxKtOyfQSwZ5UL55AmUc72X/R6M8PPOrolEBKdMtQBz1Pi
         xxQmwOUJulp+3AOAD1vTjOaT5HZ9kw1v1WXbaqqCl6nHEZ/OMih2Q5pJEELGbCTNLA
         hhmjrvfTEgYZ/4H9D2ZDOQQYrS6m1JlMynm5sWzk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jun 2018 12:47:41 +0530
From:   Govind Singh <govinds@codeaurora.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     Brian Norris <briannorris@chromium.org>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, bjorn.andersson@linaro.org,
        david.brown@linaro.org, andy.gross@linaro.org
Subject: Re: [PATCH v2 0/6]  *** Add support for wifi QMI client driver ***
In-Reply-To: <87muvrdza9.fsf@qca.qualcomm.com>
References: <20180605123304.31969-1-govinds@codeaurora.org>
 <20180619021742.GA17220@rodete-desktop-imager.corp.google.com>
 <974e34efd334d921e49d08df879c1b97@codeaurora.org>
 <87muvrdza9.fsf@qca.qualcomm.com>
Message-ID: <373f5fb7f2790f4037dc004c3acb09d5@codeaurora.org>
X-Sender: govinds@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On 2018-06-19 12:43, Kalle Valo wrote:
> Govind Singh <govinds@codeaurora.org> writes:
> 
>> 3) once supported pd info in known to Q6, tftp client in Q6
>> establishes the connection with tftp server in Q6 for user pd loading.
> 
> This sentence doesn't make sense, should it be that the tftp client in
> Q6 establishes the connection with the tftp server in user space?

Yes, you are right. TFTP server is running in apps user-space and client 
on Q6 root pd.

BR,
Govind
