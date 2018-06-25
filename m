Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFABC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0287125EF3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="YvZOsulk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0287125EF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934339AbeFYRRF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:17:05 -0400
Received: from sonic313-20.consmr.mail.bf2.yahoo.com ([74.6.133.194]:37854
        "EHLO sonic313-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933917AbeFYRRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1529947023; bh=036q4Cf9A35kAdaOIMoHmU/gdA5aUWv+IcPY7gqTQCo=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=YvZOsulkAHLU/SLWRGnoKc83FClteKY6eRgWCKSsq0Hlf9N82FJ5DsPx/HbefC7mcVtvRQATJALRCACbJROA50+pNzKev7uA3COTOrkve4x6/DtTsUUEaGgWXcHnMTJHMHmFzmmRZlHUcONkohDdTX7ehg3fcLYZpSQwbp4Fyq8jO9rxRzHjVHBlQufklOq1EijGqWtC/vYXp1+rqYcUaA6HQ6RkrQylsjOyRONfnSc2V3496RNOtG+Blg9Mmr4iDjR0pJMmbT5YDgLCYGnAYnqqbXwprk3KJh3jGjn1dkSG6lJ9XTcNcah2cdmWSFAKlSih1plSM+GXK1iwVchI+g==
X-YMail-OSG: sTmQbzYVM1kVoN3J2_.jGFqZ7MD4ixquVfGJriiMLO0h74GaLxBSN2rNElI1Ict
 MB_aRHHigz_MvLHPYIG5WofQtWYcraLZL3l6f06aCmH03526If3xZJni6BFci_wXV6XIpSj7jHcn
 ynuYSBTFZ4uRbD2jr1S_60G8eeIfRW.O3q2CuOPAG1bBa9o9iCvR3p0FiaNyz5bCsqSzU9pXE3EJ
 Jhb_TCjSyBKKIVb1YO5C0n6LTOQxwqOtY7Mg8oSgjnZ1mUJiLIz.7j3LfkeCa7HiJojzsxd8jCYs
 0luUe.iI_3Odsib6PKspy.p7zbLr6yNIrb2H_r49t6synY2DuDqeugHSUEgK3cSwhmBBKVirbH2p
 rSGKkYHc5SVmYXO8qhW1KEPEvnxFABILVSaHBBHiB4hQCxBillTRVRv4tiSrUtq68Vp6rZ7sddX3
 E30fJgxW_t2GAU4iabYLrPZDExR7oMImyH_KYfjhmw.YGl9lFg00tY.HPNOQiqnoqvsImTqk.hy4
 lWm9phf.dw1x5wsz25V2_GOORpSFqryLAzn5_x8rrKoY.BTPIsu460EpC.xrIusViazHiFNWvQFd
 Vj_eO3X51zrAohOguwFVzImNJ1yz2OqWkke4rBV4liYAjDcTU0M4zQXEAqQa790SJRYV_cw.SbIX
 ySTa6XogQjY0MvmeEPtIreyk5uoZeaXIgT9vxzr5WBJztZXEN1tXjTh4SSIep1fbbwDrCv3NZng3
 kypM4mg8DDxUVmwy8P3j_2v9b4O7E62eVUOHdm1iOqKm_UfphglZvCM9juF0WWDPr9cPvw_6nWTh
 pwoWUekRf.GclzTP8zo383EGXXaKYUUtMhe_B3nfjo317SFqCfbejLfPQVBk1.seX4PW7D2bBoC1
 6FwHfIgN80YXyLLFI32eS7EY_nZJQ1LQOkyizpimOW1HIFKf5SwfnMfa93jmQv2_TlBpwBjFDKd2
 oVuh7YSmZvRIElQx_vaSB6RucKHE0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Mon, 25 Jun 2018 17:17:03 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.105]) ([67.169.65.224])
          by smtp408.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 31e1c56e4daddbc8bbf1530586dc30f2;
          Mon, 25 Jun 2018 17:17:00 +0000 (UTC)
Subject: Re: [PULL] Smack: Mark inode instant in smack_task_to_inode
To:     James Morris <jmorris@namei.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
References: <813ecc0b-4a9e-22c9-b893-504936bab342@schaufler-ca.com>
 <alpine.LRH.2.21.1806260304580.26153@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a75c5550-4d35-8308-803b-36f4d778d243@schaufler-ca.com>
Date:   Mon, 25 Jun 2018 10:16:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1806260304580.26153@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/2018 10:05 AM, James Morris wrote:
> On Mon, 25 Jun 2018, Casey Schaufler wrote:
>
>> James, would you please pull this change for 4.18.
> I already have it queued for Linus, I'll send it up probably today.

Splendid. Thank you.

