Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B63C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52171204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52171204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbeKAVcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:32:06 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:58177 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbeKAVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:32:05 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDykM-1gS3yF1bZU-009uVg; Thu, 01 Nov 2018 13:28:23 +0100
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDykM-1gS3yF1bZU-009uVg; Thu, 01 Nov 2018 13:28:23 +0100
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
To:     Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        containers@lists.linux-foundation.org, dima@arista.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
 <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
 <1541041159.4632.6.camel@HansenPartnership.com>
 <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fcebfa0c-b389-5c4d-19b8-2f08b487ec25@vivier.eu>
Date:   Thu, 1 Nov 2018 13:28:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez3HnkRM6bUZMNjuTy5DgujgamEKhZOEWDfCjqW7fTJSzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:izDvVZ4WMX8T9SW7WIglGjWdvbGt3LvV4I5gOsyd6pxJqmB6+8X
 wmuR+Y9nB6hTAjk4rts+8Y32fe2YO99+S7XStlWPhOfJTu9DXb2RhD3KycrW0niVFtzonua
 zYJkzN9BbHgD4CYz/8iymC0scIJiLz1DxdlhhWw6Mdg/jpzHxe+mSgeUYV3WvpZDV6lb7//
 gOgHg+AAtmbD5HZi175ZQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mrd9qB4skKQ=:eOlKmn2sRb/ZzxMFHPl5u1
 hdA1DiSjT28fu3w3sgAATyhulNc/pCNoPewDBbgT3OdGWc0NcDgNywURKLSBb4Odyu7PM4/HB
 fiCYd2zbROhrmZRuoUn+hnR2dqOLiTxrPXRX5zKwgWKC64XEdfg5H2Zo5dPAizWvKxn3NE5rW
 cViL1w6XlKWovqkUyefKl9d7l6/m0cpqxWzGFU0oXQkvPr2Mw4Oz3SHyfZxPJphGe1aq4GdTg
 UqFGgzdj9e830woeAieJ173Ys3V/bqas21pLEiEI70eVhftwlglouCQ62nzsmQHorJy76Tjir
 o5rDP7Rv5MATAbwlWkp4Y+PSk8I9PflRsSogy0bpAUZTLRlYpA1Yd3Efrtc9HFGgs4oRVwhB5
 8xVwzvIih1g7ZEshVZeg1aUgzlW5w7B9bipUmzUzQ10oNg27lAUSXJmi79vxsDSeR9G7TXQfz
 Ncoz2aoLMoML2fx8cLQFGreRJF7HhwKrTdqI2aSoBNJHIhW/Egr0nqG+jcjxyRFbmLoy/PjuO
 2Dbk/syuWRUI5XdoOMQ5Z8efVsNI9lJLmBv4vz6e0fQQkYyj75frQJz2GkLvbc/7p76mETp6A
 Hsg0JRlyKGNjU9vfZfbanhNUMer4YQ7o7JOvtEQDpbBIfHlwevs/DSSSnE7UXWbB4/HUWFJJC
 vO+N1OX6sLQLaS5+RWaz76VdAqKaHDeyR7HAdCAHcqiRrKG3/ZLy1j8NBxbOtHUawomBfMswK
 qC2O+gCw1/yATfwz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/2018 04:51, Jann Horn wrote:
> On Thu, Nov 1, 2018 at 3:59 AM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>> On Tue, 2018-10-16 at 11:52 +0200, Laurent Vivier wrote:
>>> Hi,
>>>
>>> Any comment on this last version?
>>>
>>> Any chance to be merged?
>>
>> I've got a use case for this:  I went to one of the Graphene talks in
>> Edinburgh and it struck me that we seem to keep reinventing the type of
>> sandboxing that qemu-user already does.  However if you want to do an
>> x86 on x86 sandbox, you can't currently use the binfmt_misc mechanism
>> because that has you running *every* binary on the system emulated.
>> Doing it per user namespace fixes this problem and allows us to at
>> least cut down on all the pointless duplication.
> 
> Waaaaaait. What? qemu-user does not do "sandboxing". qemu-user makes
> your code slower and *LESS* secure. As far as I know, qemu-user is
> only intended for purposes like development and testing.
> 

I think the idea here is not to run qemu, but to use an interpreter
(something like gVisor) into a container to control the binaries
execution inside the container without using this interpreter on the
host itself (container and host shares the same binfmt_misc magic/mask).

Thanks,
Laurent
