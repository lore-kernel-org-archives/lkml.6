Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE098C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8413C208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8413C208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fbihome.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeH0U5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:57:04 -0400
Received: from ironchief.h-da.de ([141.100.10.235]:29926 "EHLO
        ironchief.h-da.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0U5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:57:04 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Aug 2018 16:57:03 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ERAwBDLYRb/2soZI1aGgEBAQEBAgE?=
 =?us-ascii?q?BAQEIAQEBAYNPZQNqEiiDcogQjCdPAQEBBoEILZYmgXojDYRHAoMqITQYAQI?=
 =?us-ascii?q?BAQIBAQICAmkcDIU4AQEBBAEiBFIQCw0IAwICJgICKC8GAQwGAgEBgx0BgXQ?=
 =?us-ascii?q?RC6N/ezMaAoQRAYY4BYELiEsXeYEHgTmCa4MbAwEBF4RIglcCjVuNUQmBBYU?=
 =?us-ascii?q?uhUiDbh2BP4cDBRMDhWyINoJniW05gVJNJBQ7DQSCWIJNiEiFQG0BjGoBAQ?=
X-IPAS-Result: =?us-ascii?q?A2ERAwBDLYRb/2soZI1aGgEBAQEBAgEBAQEIAQEBAYNPZ?=
 =?us-ascii?q?QNqEiiDcogQjCdPAQEBBoEILZYmgXojDYRHAoMqITQYAQIBAQIBAQICAmkcD?=
 =?us-ascii?q?IU4AQEBBAEiBFIQCw0IAwICJgICKC8GAQwGAgEBgx0BgXQRC6N/ezMaAoQRA?=
 =?us-ascii?q?YY4BYELiEsXeYEHgTmCa4MbAwEBF4RIglcCjVuNUQmBBYUuhUiDbh2BP4cDB?=
 =?us-ascii?q?RMDhWyINoJniW05gVJNJBQ7DQSCWIJNiEiFQG0BjGoBAQ?=
Received: from unknown (HELO mail.fbihome.de) ([141.100.40.107])
  by ironchief.h-da.de with ESMTP; 27 Aug 2018 18:59:26 +0200
Received: from [172.16.2.202] (unknown [194.113.41.246])
        by mail.fbihome.de (Postfix) with ESMTPSA id 5B463421DC;
        Mon, 27 Aug 2018 18:59:26 +0200 (CEST)
Subject: Re: [PATCH v4] drm/i915: Re-apply "Perform link quality check,
 unconditionally during long pulse"
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     stable@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180825191035.3945-1-lyude@redhat.com>
 <871sak5hdu.fsf@intel.com>
From:   Jan-Marek Glogowski <glogow@fbihome.de>
Openpgp: preference=signencrypt
Autocrypt: addr=glogow@fbihome.de; prefer-encrypt=mutual; keydata=
 mQGiBEDrcVsRBACdQcj/8k2CSP+5frReJ2y7AAs4+3nBKPg08yOAsdcyQJAPbRGO8r1wJ6lb
 fnJI8+y8uvmsdQ83P4262EqpShHCpI7ioPUopkAKW5dWp/NM+YjYK0m3kMI03HlHeHKAMjyc
 pUmFu0sHktbDwrDUxTksgkcRHU1bbcyVuR7yaPbpdwCgoUn/Fthp7RItKuCLktKop6BcQbsE
 AIXM5gjo5C6l7I2tXFuO1+4boEwmL2WnGFEawFB4gBaBBJ6zUHzikdZW/5WHCUalSKRd38Bi
 PW2buoftYwIjuoRj30+YEVZ/2/oZsREcIazUeZzXaP2Emr/2rRNugj5KDPfgh6v6F9+Ravkw
 z6Bixv1lti7DoP32c7oDwggJEH6LA/0UVRt4RL3gO5Dcz+KIwOVrviZCKYB6/XSMfoAUDwne
 KhnYeQCB2ylV4O/bMrHz3dkNKHfgZ6SbMFJdAmCD1Vey0819jsh/CLCz9vp2wr5IzpTanL7y
 XYjj9R/qpDaW00LZF3+Maqavi3JKAi7K0CjnbcVfV65Rm/Qs1cfrsKQTf7QnSmFuLU1hcmVr
 IEdsb2dvd3NraSA8Z2xvZ293QGZiaWhvbWUuZGU+iFsEExECABsFAkDrcVsGCwkIBwMCAxUC
 AwMWAgECHgECF4AACgkQj6MK58wZA3cK/gCfb8IUFtgcxPSuAH1w8hn4C5WuSsUAn1P1Amys
 nLextO0t3xDDrFWO3PFhuQENBEDrcV0QBADpsD+yR9/1FEKKDGq7Q+jyz7or/SEwuCG/kHk3
 G+ynZYQzFEQ0cWBw0QFzNUNnwVAvG22M0UDjBn8v7BBH0ZtlrqVRUx++6uVv5dlj1uuBp1gp
 cpAHSQgmcXxN4xYSwdJ7fPbMeAkf+8IZc99xG2geF3uZNwzPxVFBHhP7zIZqIwADBQP8D5PU
 ZfoGLr3lDFqhoj6Z6sz9wrqWBC0+zjFcCBaoK4C9x7wxIyBJVRe+yhucLlxQt+LrrU9uQjlT
 YeHqkIL96Xp3KN4y2pr98bzMEF6uIifTEpZs+D+Jq1VvUiJiVUnw0EuCTzmds7tm9CMkOXcH
 hs7GRsJSHXRSWqsXZUec3muIRgQYEQIABgUCQOtxXQAKCRCPowrnzBkDd02+AJ0caVX6EEut
 2yzgPx9/lndIHGYlhgCfXy/f9ENFxfAxMlLXjTvDUe9qye8=
Message-ID: <549c04d7-131d-e5c3-43e5-1ffdb6446d05@fbihome.de>
Date:   Mon, 27 Aug 2018 18:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <871sak5hdu.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.08.2018 um 10:43 schrieb Jani Nikula:
> On Sat, 25 Aug 2018, Lyude Paul <lyude@redhat.com> wrote:
>> From: Jan-Marek Glogowski <glogow@fbihome.de>
>>
>> This re-applies the workaround for "some DP sinks, [which] are a
>> little nuts" from commit 1a36147bb939 ("drm/i915: Perform link
>> quality check unconditionally during long pulse").
>> It makes the secondary AOC E2460P monitor connected via DP to an
>> acer Veriton N4640G usable again.
>>
>> This hunk was dropped in commit c85d200e8321 ("drm/i915: Move SST
>> DP link retraining into the ->post_hotplug() hook")
>>
>> Fixes: c85d200e8321 ("drm/i915: Move SST DP link retraining into the ->post_hotplug() hook")
>> [Cleaned up commit message, added stable cc]
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
>> Cc: stable@vger.kernel.org
>> ---
>> Resending this to update patchwork; will push in a little bit
> 
> Is there a bugzilla? Reference to a list discussion? Something with a
> dmesg where someone can actually verify this is the right fix?

The bug is at https://bugs.freedesktop.org/show_bug.cgi?id=107446
The original thread starts here:
https://lists.freedesktop.org/archives/intel-gfx/2018-August/172940.html

Jan-Marek
