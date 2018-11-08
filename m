Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B2BECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 268392077B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:19:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268392077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKIAzZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:55:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:54831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbeKIAzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:55:25 -0500
Received: from [10.230.161.1] ([217.10.52.9]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LeN3N-1fiiZO2iXV-00qFB1; Thu, 08
 Nov 2018 16:19:11 +0100
Date:   Thu, 08 Nov 2018 16:19:09 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20181108151504.GD14072@linux.intel.com>
References: <20181106150159.1136-1-roberto.sassu@huawei.com> <20181106150159.1136-5-roberto.sassu@huawei.com> <20181108140454.GE8922@linux.intel.com> <7a43680a-a216-a191-62a3-c2fb4e72d699@huawei.com> <20181108151504.GD14072@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v4 4/6] tpm: modify tpm_pcr_read() definition to pass a TPM hash algorithm
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
CC:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
From:   Peter Huewe <peterhuewe@gmx.de>
Message-ID: <289C0413-4FFB-4831-B82A-D0C3A965053D@gmx.de>
X-Provags-ID: V03:K1:QMjGP1NINSNraVcUDTS3u/isUDlBHl/6H6Br+/qNEXg7ecjUdvS
 qeda0C0NQ4RwTtJ8NAc5WQ86mdReoMs9RcCJg+GNuhnOg8e4qaDgeoIIEpPIod8zhcxTO90
 JeTvrTdZsUH7jVf/aAb8XuzFq03aXYWqsqj4RVyMpVb++8VEStXoxJP10f3EIx4SrpBA4mo
 8lBpA9xoGzTDBXBS2KPbQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6IS+jDa2M+k=:Hr1wwhbe/YvhwMRUo7v00a
 oPqq1T7P1e5VLMvf1j+SEyB07Y+LSXEC3Cv7QshWqln8NGr1M/aUeB8mQeF+YuLbg3rCxuwJo
 APj6SY2aWX+iDskh8+xxA4fUPr4GMbGTuRDg+cPxegnGL8a5nB/J1czy4W2rg/pchA4zpeETC
 gHYP/4twa0wlTaU1ATQLxAwpQk+MO5QNLtxE8FfAvxAxMXrGldr0zH2GPPeTsbldVHzCOHW4z
 Wd0no9vmIz7Em+ch2pqh9O08HsBouAa/lcWEVjCvTucIgzHJqHBzFjErkfyXI9Kktn92hQof5
 Ha0YQTwGGMTYYGw8cWXqGGwosmTSsaVVwKGdQRBFvipHiQt7FgJO9a8/nnU4xPIWjIEJmYPov
 f01odRrmo6IJofXgEdWQN2vdosDMqMV2d/3o8eIvir2T/n7mlfHMVjJ+U7JtpFT3rExdwZYC0
 HiiJ5MLtYryaj4raGuI/t0iYlpDZ0gDlaqRt797kj38YSKy0lTsIxgHfpBFkxOMJ1NcbJCJJD
 Id6/d62cyiatY9tNyQqLtLYarIQqcsrn/tSsaMGvNiT0Jh5eMf4dv33MMLbuFtj3FMdO4z26U
 +JiGH07dDSQU4g3BCdCD/m5LsmMAWfAEhznCAKzcZ2DQ25hegBts98A7fCrOjIWe/3BG5JaDD
 +lPqj0fsbNzSHOwzJNHiRF6xRdFDMTdzgR4X7AZ+7pf4PseyfJT0dn7wMxB8Cty6ypPY5zMH2
 t9pOgGY3LIKfSynmBRZeOdDz3aKu4MHJYmvxzqIhnZPYGduQoZ7w/KhcaKPSgKrXlmEkrTqje
 jYby1E5lBnTvs3NUSpHnGiybJo4B4SA73bkx5NEkdKz55KdMn6SYtTPAn9j3hXWWzqnerOXY4
 bT1d9rLZbIXuuP6GhkpFe5jwLyl3Knf6Vv8B8/EOYnYsOuhcvaOKV/fLXy48Y4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 8. November 2018 16:15:04 MEZ schrieb Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>:
>On Thu, Nov 08, 2018 at 03:16:03PM +0100, Roberto Sassu wrote:
>> On 11/8/2018 3:04 PM, Jarkko Sakkinen wrote:
>> > On Tue, Nov 06, 2018 at 04:01:57PM +0100, Roberto Sassu wrote:
>> > > Currently the TPM driver allows other kernel subsystems to read
>only the
>> > > SHA1 PCR bank. This patch modifies the parameters of
>tpm_pcr_read() and
>> > > tpm2_pcr_read() to pass a tpm_digest structure, which contains
>the desired
>> > > hash algorithm. Also, since commit 125a22105410 ("tpm: React
>correctly to
>> > > RC_TESTING from TPM 2.0 self tests") removed the call to
>tpm2_pcr_read(),
>> > > the new parameter is expected to be always not NULL.
>> > > 
>> > > Due to the API change, IMA functions have been modified.
>> > > 
>> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> > > Acked-by: Mimi Zohar <zohar@linux.ibm.com>
>> > 
>> > Does not apply to the current upstream (with tpm1-cmd.c).
>> 
>> Unfortunately, I cannot fetch the repository as infradead.org only
>> supports the git protocol (I'm behind a proxy).
>> 
>> Roberto
>
>I use a proxy script similar to this:
>
>https://gist.github.com/sit/49288
>
>(random googling but gives the idea)
>
>/Jarkko
Moving to a kernel.org repo would be really a benefit or convincing them to have a https interface as well.
We have the same proxy issue with infradead.
Peter
-- 
Sent from my mobile
