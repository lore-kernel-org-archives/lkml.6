Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E13C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB13218C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 07:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfBRHRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 02:17:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:26736 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbfBRHRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 02:17:35 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2019 23:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,383,1544515200"; 
   d="asc'?scan'208";a="117018702"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by orsmga006.jf.intel.com with ESMTP; 17 Feb 2019 23:17:33 -0800
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     kieran.bingham@ideasonboard.com,
        Jan Kiszka <jan.kiszka@siemens.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Robertson <danlrobertson89@gmail.com>
Subject: Re: [PATCH] scripts: gdb: redefine MS_RDONLY
In-Reply-To: <c20250bb-cd61-eb07-c440-866ec45010b8@ideasonboard.com>
References: <20190215112938.25574-1-felipe.balbi@linux.intel.com> <c20250bb-cd61-eb07-c440-866ec45010b8@ideasonboard.com>
Date:   Mon, 18 Feb 2019 09:17:20 +0200
Message-ID: <87d0npefb3.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Kieran Bingham <kieran.bingham@ideasonboard.com> writes:
> Hi Felipe,
>
> Thank you for the patch,
>
> On 15/02/2019 11:29, Felipe Balbi wrote:
>> Since commit e262e32d6bde0f77fb0c95d977482fc872c51996 "vfs: Suppress
>> MS_* flag defs within the kernel unless explicitly enabled", the
>> generated gdb scripts can't be used anymore. That commit moved the
>> definition of MS_* flags but forgot to update gdb scripts to use the
>> new location. This patch includes <uapi/linux/mount.h> to
>> constants.py.in so gdb scripts are functional again.
>>=20
>> Fixes: e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unle=
ss explicitly enabled"
>> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
>> ---
>>  scripts/gdb/linux/constants.py.in | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/const=
ants.py.in
>> index 7aad82406422..c2a93805d911 100644
>> --- a/scripts/gdb/linux/constants.py.in
>> +++ b/scripts/gdb/linux/constants.py.in
>> @@ -13,6 +13,7 @@
>>   */
>>=20=20
>>  #include <linux/fs.h>
>
> Do we still need linux/fs.h?

don't know enough about the tool to judge that. Just added the minimal
change to get it working again.

>> +#include <uapi/linux/mount.h>
>
> Perhaps this should go at the end to maintain alphabetical ordering?
>
>>  #include <linux/mount.h>
>>  #include <linux/of_fdt.h>
>>=20=20
>
> We can see from Dan's patch - that the comment above the value
> definitions also needs to be updated...
>
> Felipe, you won the patch race - how would you like to handle this? Will
> you resubmit with changes? or should we just add the missing Fixes: tag
> to Dan's patch?

I don't mind either way, as long as the GDB scripts are working upstream :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlxqXAIACgkQzL64meEa
mQZdEhAApibmbdkSUwN3NcqAH3bSboGBli6jQxXw3Qp0kcaCafIo5SVi4S0s+Wfy
MfetdSQR63kOBiDnWu9HaCN5f0zT35Uelctk87WMiRpGMWjI0S8p2m6bJya0dIFh
I1mRG2thMv5jxvNu6UOfZMaKY+xIQSqFihIlrKpLgUnSoneb919PaGDutasoQVXN
r9pNbzESA8kaFnc+Q2YdujW91Iz8QFV1DirWAi1eifsjsRPVt34n0rS6vIKYsf9W
rN5EZx2xYzhDwuxMz1QdkzO80yyia2XjFLOu20JkqupuvFEvnU4W9FKr6Zxk0C82
HUdZQL5BlJ37XkQ+FKDy/vCIUkP8byykm3OQeVYAkCnj9w4ukqwbkR6kpVdktsYB
NVm+3pwkL8mFYDoF0fhylJ27b0qjY0hqJcudRZk7b1CQ0+YzGEWfVg18/KeOXaoo
AbyLPIz0zhcupR2jWwtHZ+TOss0/TlYDdnIhYQOSnAQYGxr5AtAFzNPThQyXfGSM
DP902fhOR5X5Gmer0ZWCC+1ta0gFAiHSzZYmtszIiJS7IW0XZRnfcizmOtpJY1DX
9NEjkEh2dNI9q6raZ8W7Fxg/GVojdKSwoAWsnb7ReZRQSA8FYF2E8cGy2YRuTZkW
FNyXCgaoTC0893FWxhJvOtzkrWISaMh1vF6shQ8dAmgbkHHBS84=
=6eNY
-----END PGP SIGNATURE-----
--=-=-=--
