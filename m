Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D15ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BCA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:16:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37BCA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeJYBpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:45:20 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeJYBpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:45:20 -0400
Received: from [10.43.15.91] ([94.185.135.34]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1MF35K-1gLwLV3oMq-00FQKN; Wed, 24 Oct 2018 19:15:58 +0200
Received: from [10.43.15.91] ([94.185.135.34]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.184]) with ESMTPSA (Nemesis) id
 1MF35K-1gLwLV3oMq-00FQKN; Wed, 24 Oct 2018 19:15:58 +0200
Subject: Re: [PATCH v6 1/1] ns: add binfmt_misc to the user namespace
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
 <20181010161430.11633-2-laurent@vivier.eu> <20181016162245.GA7697@gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Message-ID: <0fb09ce6-e006-31a2-1f32-f3f6eda44504@vivier.eu>
Date:   Wed, 24 Oct 2018 18:15:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20181016162245.GA7697@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iiQD9ckAiFLTBKMZ1aJxZN0Qflsphi71k9meEBIC8QASsiKcVvb
 N4l1RZoCaGoBadYiuiV0mYFdXXtyggbTfpbqUgmAS6j0t2t8pF1A2rITPg0Q+Dls1t0funH
 KsOdbzGrVdvnhLsCtSNmfJyT3TPOBG5seKfqi6EErpzKmR1FzJqHfrqo9pInxnQ/XtfhNer
 IcIem34IkIO5bwoSGlVGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JCwADjGa0Lo=:w0yaDMiWIqp7AHd11N3aZ3
 6NL+bYC67rWIlR9QfiAEP1yUkQogCMfJZqUpk5FHAQnCvx0b1/FyfZOgnVO/uDbftkauAGscr
 zNWIlX9Q6qzEYWa4fnuhQWX/m3hlPFJs8A9EUu+o+N0wDGXI5WHisVfZ0pnO9rOW40MV5asY3
 DfvubLYvvQAoq7Hq6vykOExsAgYjV7aI8dweIEv1xGxBaHKl4dluhdRAe+iFBMnNIZRA86mLh
 VV8mXPLTKunw2E3NHiwtJz94fBCXxzkszpDlV+PNoIuOMBz59EY12BW/w/+YXgP2kTNclLTu3
 HSt3dZcyJjSzkLArItv9guNt6ZgzFr/7urdbkl9/qYVlZvZs/Jrb0xMu8PGuyPb/wTjqMs8Rf
 Gb130tqVHKvjWaMT6pTlvapqV1sHCEeG3I7fbzMiZ7mAvl9Agz0xyRDxjjZt2rbvIqRUotG/d
 KF/w4kwRTTPDJXqWeqH0E3aZQ/vEYpHIvFnNKQcWwQpegqCLiZbv9VkRJYzcAu9tePP5reTVD
 EM0EFrEm6Oi7Yr9s65g4ylZN6A6NdXTHIHN34uShUsVg5sqmS0e4VGUREg1vTQFG7mLBEnWQh
 1J6qnTlp5wYzJuVFm4mC9XeN6wK5P5mx3Zq61PtfOIKOKIg70sjJfFVionpLWRRWjuGiGUXBM
 HyCZiHwAHtVk7M/tOKFCUvaYegWzeOD1sPg5DcwnXQe6JzGJBqiJc39rZKf5P/S340DIqUnE5
 T2/R4Cqr6S5cmUa2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2018 17:22, Andrei Vagin wrote:
> On Wed, Oct 10, 2018 at 06:14:30PM +0200, Laurent Vivier wrote:
>> This patch allows to have a different binfmt_misc configuration
>> for each new user namespace. By default, the binfmt_misc configuration
>> is the one of the previous level, but if the binfmt_misc filesystem is
>> mounted in the new namespace a new empty binfmt instance is created and
>> used in this namespace.
>>
>> For instance, using "unshare" we can start a chroot of another
>> architecture and configure the binfmt_misc interpreter without being root
>> to run the binaries in this chroot.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> 
> Acked-by: Andrei Vagin <avagin@gmail.com>
> 
> Thanks,
> Andrei
> 

I don't konw who is the maintainer for this part, but is there any
chance to have this merged in 4.20?

Thanks,
Laurent

