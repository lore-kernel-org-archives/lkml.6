Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5F02084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfBUN2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:28:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:32944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbfBUN2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:28:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 701E0AEA6;
        Thu, 21 Feb 2019 13:28:33 +0000 (UTC)
Subject: Re: [PATCH] acpi/nfit: Fix bus command validation
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishal Verma <vishal.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49lg2bql2v.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4iiZS_zfroRtmS-zD-cCDj1yQonBsWM23utR9m9kiBizA@mail.gmail.com>
 <b1f73551-5c11-3651-dc6f-5cdcf815e0d0@suse.de>
 <CAPcyv4hZXJbrLc9f3xsOTPs_RYVH9vhuxSxHj-4L56ZNi+ZRZg@mail.gmail.com>
 <fcbf4a2c-a4c4-556e-f2dc-c22663997de5@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=jthumshirn@suse.de; prefer-encrypt=mutual; keydata=
 xsFNBFTTwPEBEADOadCyru0ZmVLaBn620Lq6WhXUlVhtvZF5r1JrbYaBROp8ZpiaOc9YpkN3
 rXTgBx+UoDGtnz9DZnIa9fwxkcby63igMPFJEYpwt9adN6bA1DiKKBqbaV5ZbDXR1tRrSvCl
 2V4IgvgVuO0ZJEt7gakOQlqjQaOvIzDnMIi/abKLSSzYAThsOUf6qBEn2G46r886Mk8MwkJN
 hilcQ7F5UsKfcVVGrTBoim6j69Ve6EztSXOXjFgsoBw4pEhWuBQCkDWPzxkkQof1WfkLAVJ2
 X9McVokrRXeuu3mmB+ltamYcZ/DtvBRy8K6ViAgGyNRWmLTNWdJj19Qgw9Ef+Q9O5rwfbPZy
 SHS2PVE9dEaciS+EJkFQ3/TBRMP1bGeNbZUgrMwWOvt37yguvrCOglbHW+a8/G+L7vz0hasm
 OpvD9+kyTOHjqkknVJL69BOJeCIVUtSjT9EXaAOkqw3EyNJzzhdaMXcOPwvTXNkd8rQZIHft
 SPg47zMp2SJtVdYrA6YgLv7OMMhXhNkUsvhU0HZWUhcXZnj+F9NmDnuccarez9FmLijRUNgL
 6iU+oypB/jaBkO6XLLwo2tf7CYmBYMmvXpygyL8/wt+SIciNiM34Yc+WIx4xv5nDVzG1n09b
 +iXDTYoWH82Dq1xBSVm0gxlNQRUGMmsX1dCbCS2wmWbEJJDEeQARAQABzSdKb2hhbm5lcyBU
 aHVtc2hpcm4gPGp0aHVtc2hpcm5Ac3VzZS5kZT7CwYAEEwEIACoCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AFCQo9ta8FAlohZmoCGQEACgkQA5OWnS12CFATLQ//ajhNDVJLK9bjjiOH
 53B0+hCrRBj5jQiT8I60+4w+hssvRHWkgsujF+V51jcmX3NOXeSyLC1Gk43A9vCz5gXnqyqG
 tOlYm26bihzG02eAoWr/glHBQyy7RYcd97SuRSv77WzuXT3mCnM15TKiqXYNzRCK7u5nx4eu
 szAU+AoXAC/y1gtuDMvANBEuHWE4LNQLkTwJshU1vwoNcTSl+JuQWe89GB8eeeMnHuY92T6A
 ActzHN14R1SRD/51N9sebAxGVZntXzSVKyMID6eGdNegWrz4q55H56ZrOMQ6IIaa7KSz3QSj
 3E8VIY4FawfjCSOuA2joemnXH1a1cJtuqbDPZrO2TUZlNGrO2TRi9e2nIzouShc5EdwmL6qt
 WG5nbGajkm1wCNb6t4v9ueYMPkHsr6xJorFZHlu7PKqB6YY3hRC8dMcCDSLkOPWf+iZrqtpE
 odFBlnYNfmAXp+1ynhUvaeH6eSOqCN3jvQbITUo8mMQsdVgVeJwRdeAOFhP7fsxNugii721U
 acNVDPpEz4QyxfZtfu9QGI405j9MXF/CPrHlNLD5ZM5k9NxnmIdCM9i1ii4nmWvmz9JdVJ+8
 6LkxauROr2apgTXxMnJ3Desp+IRWaFvTVhbwfxmwC5F3Kr0ouhr5Kt8jkQeD/vuqYuxOAyDI
 egjo3Y7OGqct+5nybmbOwU0EVNPA8QEQAN/79cFVNpC+8rmudnXGbob9sk0J99qnwM2tw33v
 uvQjEGAJTVCOHrewDbHmqZ5V1X1LI9cMlLUNMR3W0+L04+MH8s/JxshFST+hOaijGc81AN2P
 NrAQD7IKpA78Q2F3I6gpbMzyMy0DxmoKF73IAMQIknrhzn37DgM+x4jQgkvhFMqnnZ/xIQ9d
 QEBKDtfxH78QPosDqCzsN9HRArC75TiKTKOxC12ZRNFZfEPnmqJ260oImtmoD/L8QiBsdA4m
 Mdkmo6Pq6iAhbGQ5phmhUVuj+7O8rTpGRXySMLZ44BimM8yHWTaiLWxCehHgfUWRNLwFbrd+
 nYJYHoqyFGueZFBNxY4bS2rIEDg+nSKiAwJv3DUJDDd/QJpikB5HIjg/5kcSm7laqfbr1pmC
 ZbR2JCTp4FTABVLxt7pJP40SuLx5He63aA/VyxoInLcZPBNvVfq/3v3fkoILphi77ZfTvKrl
 RkDdH6PkFOFpnrctdTWbIFAYfU96VvySFAOOg5fsCeLv9/zD4dQEGsvva/qKZXkH/l2LeVp3
 xEXoFsUZtajPZgyRBxer0nVWRyeVwUQnLG8kjEOcZzX27GUpughi8w42p4oMD+96tr3BKTAr
 guRHJnU1M1xwRPbw5UsNXEOgYsFc8cdto0X7hQ2Ugc07CRSDvyH50IKXf2++znOTXFDhABEB
 AAHCwV8EGAECAAkFAlTTwPECGwwACgkQA5OWnS12CFAdRg//ZGV0voLRjjgX9ODzaz6LP+IP
 /ebGLXe3I+QXz8DaTkG45evOu6B2J53IM8t1xEug0OnfnTo1z0AFg5vU53L24LAdpi12CarV
 Da53WvHzG4BzCVGOGrAvJnMvUXf0/aEm0Sen2Mvf5kvOwsr9UTHJ8N/ucEKSXAXf+KZLYJbL
 NL4LbOFP+ywxtjV+SgLpDgRotM43yCRbONUXEML64SJ2ST+uNzvilhEQT/mlDP7cY259QDk7
 1K6B+/ACE3Dn7X0/kp8a+ZoNjUJZkQQY4JyMOkITD6+CJ1YsxhX+/few9k5uVrwK/Cw+Vmae
 A85gYfFn+OlLFO/6RGjMAKOsdtPFMltNOZoT+YjgAcW6Q9qGgtVYKcVOxusL8C3v8PAYf7Ul
 Su7c+/Ayr3YV9Sp8PH4X4jK/zk3+DDY1/ASE94c95DW1lpOcyx3n1TwQbwp6TzPMRe1IkkYe
 0lYj9ZgKaZ8hEmzuhg6FKXk9Dah+H73LdV57M4OFN8Xwb7v+oEG23vdsb2KBVG5K6Tv7Hb2N
 sfHWRdU3quYIistrNWWeGmfTlhVLgDhEmAsKZFH05QsAv3pQv7dH/JD+Tbn6sSnNAVrATff1
 AD3dXmt+5d3qYuUxam1UFGufGzV7jqG5QNStp0yvLP0xroB8y0CnnX2FY6bAVCU+CqKu+n1B
 LGlgwABHRtLCwe0EGAEIACAWIQTsOJyrwsTyXYYA0NADk5adLXYIUAUCWsTXAwIbAgCBCRAD
 k5adLXYIUHYgBBkWCAAdFiEEx1U9vxg1xAeUwus20p7yIq+KHe4FAlrE1wMACgkQ0p7yIq+K
 He6RfAEA+frSSvrHiuatNqvgYAJcraYhp1GQJrWSWMmi2eFcGskBAJyLp47etEn3xhJBLVVh
 2y2K4Nobb6ZgxA4Svfnkf7AAdicQALiaOKDwKD3tgf90ypEoummYzAxv8MxyPXZ7ylRnkheA
 eQDxuoc/YwMA4qyxhzf6K4tD/aT12XJd95gk+YAL6flGkJD8rA3jsEucPmo5eko4Ms2rOEdG
 jKsZetkdPKGBd2qVxxyZgzUkgRXduvyux04b9erEpJmoIXs/lE0IRbL9A9rJ6ASjFPGpXYrb
 73pb6Dtkdpvv+hoe4cKeae4dS0AnDc7LWSW3Ub0n61uk/rqpTmKuesmTZeB2GHzLN5GAXfNj
 ELHAeSVfFLPRFrjF5jjKJkpiyq98+oUnvTtDIPMTg05wSN2JtwKnoQ0TAIHWhiF6coGeEfY8
 ikdVLSZDEjW54Td5aIXWCRTBWa6Zqz/G6oESF+Lchu/lDv5+nuN04KZRAwCpXLS++/givJWo
 M9FMnQSvt4N95dVQE3kDsasl960ct8OzxaxuevW0OV/jQEd9gH50RaFif412DTrsuaPsBz6O
 l2t2TyTuHm7wVUY2J3gJYgG723/PUGW4LaoqNrYQUr/rqo6NXw6c+EglRpm1BdpkwPwAng63
 W5VOQMdnozD2RsDM5GfA4aEFi5m00tE+8XPICCtkduyWw+Z+zIqYk2v+zraPLs9Gs0X2C7X0
 yvqY9voUoJjG6skkOToGZbqtMX9K4GOv9JAxVs075QRXL3brHtHONDt6udYobzz+
Message-ID: <cb6d55e7-8544-ce28-55e5-f4c0361a256f@suse.de>
Date:   Thu, 21 Feb 2019 14:28:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <fcbf4a2c-a4c4-556e-f2dc-c22663997de5@suse.de>
Content-Type: multipart/mixed;
 boundary="------------892760BAE4EE405FB98D14F6"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------892760BAE4EE405FB98D14F6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

[+CC dvyukov ]

On 20/02/2019 18:21, Johannes Thumshirn wrote:
> On 20/02/2019 17:15, Dan Williams wrote:> I wouldn't be opposed to
> syzkaller fuzzing the nvdimm-ioctl path.
> As a heads up, I've started adding the ioctl() definitions to syzcaller.
> Just so we don't duplicate any efforts.

So AFAICS this (see attachment) should do the trick.

@dvyukov is there something I'm missing, or can syzkaller pick up the
/dev/ndctl devices and start fuzzing the ioctl path with this?

Thanks,
	Johannes
-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

--------------892760BAE4EE405FB98D14F6
Content-Type: text/plain; charset=UTF-8;
 name="dev_ndctl.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dev_ndctl.txt"

IyBDb3B5cmlnaHQgMjAxOSBzeXprYWxsZXIgcHJvamVjdCBhdXRob3JzLiBBbGwgcmlnaHRz
IHJlc2VydmVkLgojIFVzZSBvZiB0aGlzIHNvdXJjZSBjb2RlIGlzIGdvdmVybmVkIGJ5IEFw
YWNoZSAyIExJQ0VOU0UgdGhhdCBjYW4gYmUgZm91bmQgaW4gdGhlIExJQ0VOU0UgZmlsZS4K
CiNpbmNsdWRlIDxhc20vaW9jdGwuaD4KI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CiNpbmNs
dWRlIDx1YXBpL2xpbnV4L25kY3RsLmg+CgpyZXNvdXJjZSBmZF9uZGN0bFtmZF0KCnN5el9v
cGVuX2RldiRuZGN0bChkZXYgcHRyW2luLCBzdHJpbmdbIi9kZXYvbmRjdGwjIl1dLCBpZCBp
bnRwdHIsIGZsYWdzIGZsYWdzW29wZW5fZmxhZ3NdKSBmZF9uZGN0bAoKaW9jdGwkTkRfSU9D
VExfRElNTV9GTEFHUyhmZCBmZF9uZGN0bCwgY21kIGNvbnN0W05EX0lPQ1RMX0RJTU1fRkxB
R1NdLCBhcmcgcHRyW2luLCBuZF9jbWRfZGltbV9mbGFnc10pCmlvY3RsJE5EX0lPQ1RMX0dF
VF9DT05GSUdfU0laRShmZCBmZF9uZGN0bCwgY21kIGNvbnN0W05EX0lPQ1RMX0dFVF9DT05G
SUdfU0laRV0sIGFyZyBwdHJbaW4sIG5kX2NtZF9nZXRfY29uZmlnX3NpemVdKQppb2N0bCRO
RF9JT0NUTF9HRVRfQ09ORklHX0RBVEEoZmQgZmRfbmRjdGwsIGNtZCBjb25zdFtORF9JT0NU
TF9HRVRfQ09ORklHX0RBVF0sIGFyZyBwdHJbaW4sIG5kX2NtZF9nZXRfY29uZmlnX2RhdGFf
aGRyXSkKaW9jdGwkTkRfSU9DVExfU0VUX0NPTkZJR19EQVRBKGZkIGZkX25kY3RsLCBjbWQg
Y29uc3RbTkRfSU9DVExfU0VUX0NPTkZJR19EQVRBXSwgYXJnIHB0cltpbiwgbmRfY21kX3Nl
dF9jb25maWdfaGRyXSkKaW9jdGwkTkRfSU9DVExfVkVORE9SKGZkIGZkX25kY3RsLCBjbWQg
Y29uc3RbTkRfSU9DVExfVkVORE9SXSwgYXJnIHB0cltpbiwgbmRfY21kX3ZlbmRvcl9oZHJd
KQoKaW9jdGwkTkRfSU9DVExfQVJTX0NBUChmZCBmZF9uZGN0bCwgY21kIGNvbnN0W05EX0lP
Q1RMX0FSU19DQVBdLCBhcmcgcHRyW2luLCBuZF9jbWRfYXJzX2NhcF0pCmlvY3RsJE5EX0lP
Q1RMX0FSU19TVEFSVChmZCBmZF9uZGN0bCwgY21kIGNvbnN0W05EX0lPQ1RMX0FSU19TVEFS
VF0sIGFyZyBwdHJbaW4sIG5kX2NtZF9hcnNfc3RhcnRdKQppb2N0bCRORF9JT0NUTF9BUlNf
U1RBVFVTKGZkIGZkX25kY3RsLCBjbWQgY29uc3RbTkRfSU9DVExfQVJTX1NUQVRVU10sIGFy
ZyBwdHJbaW4sIG5kX2NtZF9hcnNfc3RhdHVzXSkKaW9jdGwkTkRfSU9DVExfQ0xFQVJfRVJS
T1IoZmQgZmRfbmRjdGwsIGNtZCBjb25zdFtORF9JT0NUTF9DTEVBUl9FUlJPUl0sIGFyZyBw
dHJbaW4sIG5kX2NtZF9jbGVhcl9lcnJvcl0pCmlvY3RsJE5EX0lPQ1RMX0NBTEwoZmQgZmRf
bmRjdGwsIGNtZCBjb25zdFtORF9JT0NUTF9DQUxMXSwgYXJnIHB0cltpbiwgbmRfY21kX3Br
Z10pCgpuZF9jbWRfZGltbV9mbGFncyB7CglzdGF0dXMJaW50MzIKCWZsYWdzCWludDMyCn0g
W3BhY2tlZF0KCm5kX2NtZF9nZXRfY29uZmlnX3NpemUgewoJc3RhdHVzCQlpbnQzMgoJY29u
ZmlnX3NpemUJaW50MzIKCW1heF94ZmVyCWludDMyCn0gW3BhY2tlZF0KCm5kX2NtZF9nZXRf
Y29uZmlnX2RhdGFfaGRyIHsKCWluX29mZnNldAlpbnQzMgoJaW5fbGVuZ3RoCWxlbltvdXRf
YnVmLCBpbnQzMl0KCXN0YXR1cwkJaW50MzIKCW91dF9idWYJCXB0cltvdXQsIGFycmF5W2lu
dDhdCn0gW3BhY2tlZF0KCnN0cnVjdCBuZF9jbWRfc2V0X2NvbmZpZ19oZHIgewoJaW5fb2Zm
c2V0CWludDMyCglpbl9sZW5ndGgJbGVuW2luX2J1ZiwgaW50MzJdCglpbl9idWYJCXB0cltp
biwgYXJyYXlbaW50OF0KfSBbcGFja2VkXQoKc3RydWN0IG5kX2NtZF92ZW5kb3JfaGRyIHsK
CW9wY29kZQkJaW50MzIKCWluX2xlbmd0aAlsZW5baW5fYnVmLCBpbnQzMl0KCWluX2J1ZgkJ
cHRyW2luLCBhcnJheVtpbnQ4XQp9IFtwYWNrZWRdCgpuZF9jbWRfYXJzX2NhcCB7CglhZGRy
ZXNzCQlpbnQ2NAogICAgICAgIGxlbmd0aAkJaW50NjQKICAgICAgICBzdGF0dXMJCWludDMy
CiAgICAgICAgbWF4X2Fyc19vdXQJaW50MzIKICAgICAgICBjbGVhcl9lcnJfdW5pdAlpbnQz
MgogICAgICAgIGZsYWdzCQlpbnQxNgogICAgICAgIHJlc2VydmVkCWludDE2Cn0gW3BhY2tl
ZF0KCm5kX2NtZF9hcnNfc3RhcnQgewogICAgICAgIGFkZHJlc3MJCWludDY0CiAgICAgICAg
bGVuZ3RoCQlpbnQ2NAogICAgICAgIHR5cGUJCWludDE2CiAgICAgICAgZmxhZ3MJCWludDgK
ICAgICAgICByZXNlcnZlZAlhcnJheVtjb25zdFswLCBpbnQ4XSwgNV0KICAgICAgICBzdGF0
dXMJCWludDMyCiAgICAgICAgc2NydWJfdGltZQlpbnQzMgp9IFtwYWNrZWRdCgp0eXBlIG5k
X2Fyc19yZWNvcmQgewoJaGFuZGxlCQlpbnQzMgoJcmVzZXJ2ZWQJaW50MzIKCWVycl9hZGRy
ZXNzCWludDY0CglsZW5ndGgJCWludDY0Cn0gW3BhY2tlZF0KCm5kX2NtZF9hcnNfc3RhdHVz
IHsKICAgICAgICBzdGF0dXMJCWludDMyCiAgICAgICAgb3V0X2xlbmd0aAlpbnQzMgogICAg
ICAgIGFkZHJlc3MJCWludDY0CiAgICAgICAgbGVuZ3RoCQlpbnQ2NAogICAgICAgIHJlc3Rh
cnRfYWRkcmVzcyBpbnQ2NAogICAgICAgIHJlc3RhcnRfbGVuZ3RoCWludDY0CiAgICAgICAg
dHlwZQkJaW50MTYKICAgICAgICBmbGFncwkJaW50MTYKICAgICAgICBudW1fcmVjb3Jkcwls
ZW5bcmVjb3JkcywgaW50MzJdCglyZWNvcmRzCQlwdHJbb3V0LCBhcnJheVtuZF9hcnNfcmVj
b3Jkc10KfSBbcGFja2VkXQoKbmRfY21kX2NsZWFyX2Vycm9yIHsKICAgICAgICBhZGRyZXNz
CQlpbnQ2NAogICAgICAgIGxlbmd0aAkJaW50NjQKICAgICAgICBzdGF0dXMJCWludDMyCiAg
ICAgICAgcmVzZXJ2ZWQJYXJyYXlbY29uc3RbMCwgaW50OF0sIDRdCiAgICAgICAgY2xlYXJl
ZAkJaW50NjQKfSBbcGFja2VkXQoKbmRfY21kX3BrZyB7CgluZF9mYW1pbHkJaW50NjQKCW5k
X2NvbW1hbmQJaW50NjQKCW5kX3NpemVfaW4gCWxlbltuZF9wYXlsb2FkLCBpbnQzMl0KCW5k
X3NpemVfb3V0CWludDMyCgluZF9yZXNlcnZlZDIJYXJyYXlbY29uc3RbMCwgaW50MzJdLCA5
XQoJbmRfZndfc2l6ZQlpbnQzMgoJbmRfcGF5bG9hZAlwdHIgW2luLCBhcnJheVtpbnQ4XV0K
Cn0gW3BhY2tlZF0K
--------------892760BAE4EE405FB98D14F6--
