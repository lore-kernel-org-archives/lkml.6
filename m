Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0BAECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB522214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 15:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="aqc+4sBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB522214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbeIRU4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:56:22 -0400
Received: from sonic306-9.consmr.mail.bf2.yahoo.com ([74.6.132.48]:40970 "EHLO
        sonic306-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729753AbeIRU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537284197; bh=ZyxPJuQATKXv1ZWPXEhQP8FaqwXdmMwlnYrhJcmEyko=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=aqc+4sBLiypNfqVLD+TZBg1IswcXZ8fWlMlTfu9PkpDz2KUDvzDPRHBGfjaAEmMHEVD4TLfgoZ1JNuukO5ayGfM4UNtizLpntUgOCX/oRlEqm6Y45wz3OWHPYvhjFWznSy015OrY7v4uDRdzNce4v4vqq2Za1pMjZmfKyFa2VAL3+eaMIA22zwOXhG3HonbqOAPZEKomISO9roTi6pPWl2vNKq/8RBHehDBTmIhRYCx+B6Y7aOhE9dZxu+3UqtK43HNI2toKy2eDkumVNZE8MXmVYhDg9u6UlgyB+42v8WkFimP5HjsCS5xK7XAwfxSesSin8mVjHigmkldfBqIEtw==
X-YMail-OSG: giGDLuwVM1kAqP_e2JAk_lQNN7bVXDlrZKAnmaNKTd_S7OvuZD5r1TR2nZn4t0y
 BfQ6M26utyONuhMBKgR6iI1z2SxxpCIiRfjlbUEjFe5mBIV66lFIJ1kfYOgzugviBmsDf0PJL10W
 DOOTut_tJCFiqJoIv9oNOdQ_HDWXPxxR52UqAQb27CaDxcS_DRMy6tsTwMNAk4lLDbhM_ViMS7bS
 Nj4o8UsQEVhW0cRPlY5vaimzV25fEv81sErH6lXTsZckAON8Q8HdBkKQdulLIIN3mhEI9NC6loVJ
 wn2QvEFvh2sSsv__iCCbd.mFyKh1Hnbx37bWkPsStbyBPXNL2cZvHWhaHrmtRhmHNov8x_FC6fAW
 SmdbT_7n.LAWThDAaciBEcN3j_ecMbYIJHtko.QOlrLqSZzVlNmNRgKmkPV62gD.Wnd_fRHdmCST
 OVBMGTCDqqIuXzbKX6x2U_HXlVpyO_0J7pEQI_WPqzzRFQKKaaOSO5_OY8KtuZVCvoVeqH60X6gT
 r7kva0Xp.Vev2lALOk94JSPkIX3s5tBPucu36uiOfXScGc1yRvuA1Wrlb_B5TXOfPdxwtmKeJKZu
 idLImLCUbTqKyQ6paPKg5lAHq9c.hAPeo5drB2TdvrQyYhdks2OBwukardBt9OZ6v.ZRg7_OAF44
 Z03Fs.qLCPI.lv.outXC2.X.Hg8Y0HNEIhJ4j_k1YV11NTosW_3PJdWmRSw8zWkHiVwMyrsdHEcX
 fgcCc2qxBYmllQBpiLou91uD4QsJctc_CErB.c3vQdzHhRpfMmz4lQgnrPqy3oT_bMijF4V9OsKV
 Yl7tg6E2hO9iXbG3XZTnJPee9XkFYdtEgWMkcEQQEvqfxfbaZiRv043YRnvtgl0fs7Da2hMn2.Tr
 tSCeLjVTlL54wzST5O0wA2vCte8FR_PaueJKSXMzE891ENIb3jrQeEbJC.by_.2yusbmdBtzIG_R
 XGq5pJxG_3OogX_hZd3hr09x_c010xgbVE1cujQVEg9waAzWpY0uEylY6kp7Vr49bqlPaiQG4kvk
 g0XRUWEmwCPOyrT8emAo2k8O1mg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Sep 2018 15:23:17 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 18fb3dacc0f67ebce977ba465cff0985;
          Tue, 18 Sep 2018 15:23:17 +0000 (UTC)
Subject: Re: [PATCH v2 00/10] LSM: Module stacking in support of S.A.R.A and
 Landlock
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc:     LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Schaufler, Casey" <casey.schaufler@intel.com>
References: <cbf848ae-a1ac-c5ab-f23b-bc9217fceebe@schaufler-ca.com>
 <alpine.LRH.2.21.1809130727310.19741@namei.org>
 <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <6c678308-fae3-22b0-8750-20d1b70e1bc5@schaufler-ca.com>
Date:   Tue, 18 Sep 2018 08:23:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d2ad1caf-4e81-f33d-f764-6f90f9d101c4@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 12:44 AM, Mickaël Salaün wrote:
> On 9/12/18 23:29, James Morris wrote:
>> Adding the SARA and LandLock authors for review & comment.
>>
>> Salvatore & Mickaël: does this patchset meet your needs for merging to 
>> mainline?
> It almost does! For now, I need the task_struct, cred, inode and file
> security blobs. Only the task_struct one is missing.

I will add the task blob as well as the ipc blob needed by
SARA for v3.
 

>
> FYI, the capitalization of Landlock is not consistent in all commit
> messages. :)

Sorry. I have been trying to get people to use Smack instead
of SMACK for years. I will strive to use Landlock consistently.

