Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751576AbeCTGND (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:13:03 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33083 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTGNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:13:01 -0400
X-Google-Smtp-Source: AG47ELsUVCP6YJFdVxadNeZtRb7Hs5r7HpaS206pfc3sPbYayI9ReGp4PaHrs5nTHw/h/O72n5si81+566+c8xZdHWo=
MIME-Version: 1.0
From: Satish Baddipadige <satish.baddipadige@broadcom.com>
Date: Tue, 20 Mar 2018 11:42:59 +0530
Message-ID: <CA+oDAx908Dpn93-c4ogS5F1XZJri9GC_WaFR8wuDKO47kygB5w@mail.gmail.com>
Subject: Re: tg3 crashes under high load, when using 100Mbits
To: Siva Reddy Kallam <siva.kallam@broadcom.com>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stanley Hsiao <stanley.hsiao@canonical.com>,
        Tim Chen <tim.chen119@canonical.com>
Content-Type: multipart/mixed; boundary="0000000000006b9a210567d1f729"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006b9a210567d1f729
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 7:37 PM, Siva Reddy Kallam
<siva.kallam@broadcom.com> wrote:
> On Mon, Feb 12, 2018 at 10:59 AM, Siva Reddy Kallam
> <siva.kallam@broadcom.com> wrote:
>> On Fri, Feb 9, 2018 at 10:41 AM, Kai Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>>> Hi Broadcom folks,
>>>
>>> We are now enabling a new platform with tg3 nic, unfortunately we obser=
ved
>>> the bug [1] that dated back to 2015.
>>> I tried commit 4419bb1cedcd ("tg3: Add workaround to restrict 5762 MRRS=
 to
>>> 2048=E2=80=9D) but it does=E2=80=99t work.
>>>
>>> Do you have any idea how to solve the issue?
>>>
>>> [1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1447664
>>>
>>> Kai-Heng
>>>
>> Thank you for reporting. We will check and update you.
> With link aware mode, the clock speed could be slow and boot code does no=
t
> complete within the expected time with lower link speeds. Need to overrid=
e
> and the clock in driver. We are checking the feasibility of adding
> this in driver or firmware.

Hi Kai-Heng,

Can you please test the attached patch?

Thanks,
Satish

--0000000000006b9a210567d1f729
Content-Type: application/octet-stream; name="tg3_5762_clock_override.patch"
Content-Disposition: attachment; filename="tg3_5762_clock_override.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jez9iicb0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL3RnMy5jIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmMKaW5kZXggZjI1OTM5Ny4uZDI3MzM3ZCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmMKKysrIGIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vdGczLmMKQEAgLTkwMTAsNiArOTAxMCw3IEBAIHN0YXRp
YyB2b2lkIHRnM19vdmVycmlkZV9jbGsoc3RydWN0IHRnMyAqdHApCiAKIAlzd2l0Y2ggKHRnM19h
c2ljX3Jldih0cCkpIHsKIAljYXNlIEFTSUNfUkVWXzU3MTc6CisJY2FzZSBBU0lDX1JFVl81NzYy
OgogCQl2YWwgPSB0cjMyKFRHM19DUE1VX0NMQ0tfT1JJREVfRU5BQkxFKTsKIAkJdHczMihURzNf
Q1BNVV9DTENLX09SSURFX0VOQUJMRSwgdmFsIHwKIAkJICAgICBURzNfQ1BNVV9NQUNfT1JJREVf
RU5BQkxFKTsKQEAgLTkwMzEsNiArOTAzMiw3IEBAIHN0YXRpYyB2b2lkIHRnM19yZXN0b3JlX2Ns
ayhzdHJ1Y3QgdGczICp0cCkKIAogCXN3aXRjaCAodGczX2FzaWNfcmV2KHRwKSkgewogCWNhc2Ug
QVNJQ19SRVZfNTcxNzoKKwljYXNlIEFTSUNfUkVWXzU3NjI6CiAJCXZhbCA9IHRyMzIoVEczX0NQ
TVVfQ0xDS19PUklERV9FTkFCTEUpOwogCQl0dzMyKFRHM19DUE1VX0NMQ0tfT1JJREVfRU5BQkxF
LAogCQkgICAgIHZhbCAmIH5URzNfQ1BNVV9NQUNfT1JJREVfRU5BQkxFKTsK
--0000000000006b9a210567d1f729--
