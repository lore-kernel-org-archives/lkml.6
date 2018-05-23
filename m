Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4125586-1527069154-3-7134442448063259732
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527069153; b=nRqGrIdUKHyInNhLGxI6ySNnMoPAWUWLHtBuKKyPvNGfoGIAa2
    5wAefubDS41wFEbQ/6SK4iamzUkbmLsH5GVuv9QOQK3rUE20V0vEa5dLRxfUQpSc
    I8KwNi2mBuJDVu6N/vHxo36pTKS7ltcWDsvZBAMXqR25lCFFDpceTneWiMWSFOQu
    FF3c/RsRNcj7P/lwhckjQ5ZNSYGKboAoVcFVrOomWxVNOXGjOSlFX527i90AUV1/
    ZeJPiZNGzrAS4rFTTdavUUp7BdnF/LzBp1SxdCh9qLxepVFSjLFxQbPmaFphVK95
    n1sgHRkBRXc4/M+uusRQNMjmQozoKY+6JMVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:cc:references:to:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527069153;
    bh=npUvABQgzldHXzRaKvQsJX9I6j1Noy2d6a+qsHNKnjM=; b=N9hmVNsuXdzX
    cdMUAk9aNmhE5mPGEbfzBjwS2IUO/a1ArcyZkQ4BjvymyfklUcFVT3oTxpa95Fdq
    7B0CwAC6OlnhKvhGeGj+ACGMNK9Bz/IGz8nHp6bh46Q7bK5uUYOYayb8rn4DhnmI
    B0rLbe6ZndDKIHMLBZHYMFqJnWMYXD/tjdxKnWNys8xMMiSTN7oh379s33RG0+lt
    ZoxmAJftXZu4BalcjABwkhf+MFipdNv7O6+/SZLS6/n7YDBSnWgyluFclNAJwc7e
    gPugL179/RfFpJdAv3WtwToTjkEWqaufvBwusPvvIAqTI6MzkYOuOiwwhjRstO3F
    uTnEFbtCBQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de
    header.i=@amazon.de header.b=EQpvvb1M x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=amazon.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de
      header.i=@amazon.de header.b=EQpvvb1M x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=amazon.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJFp+WAvpILNXLWqx0hQw/ZO8hEQ277oSjjgtLsbszbG3CfogedkJVZTYbfGGcyGVqNp9pyoqAFnT/9oPsY8Z0WeC9O4Jw3e76s9sJLxHqbcSJopi3V
    2yy8f8LqSsrRXybExj2stOqBrBapRtADfSWlgUrfv+CnXjZu4h6S2FeNiEYk6Ox9l9akTMVHGH5cJy9HHdlz8MwAwI8vhP0t/JyZXe2uzCA5ME1w+tN29l4O
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=doQTAlNhncQA:10 a=IkcTkHD0fZMA:10
    a=O76VCmqbo-wA:10 a=VUJBJC2UJ8kA:10 a=D19gQVrFAAAA:8 a=2CHfQ5Y1VuxGrYD4R7YA:9
    a=QEXdDO2ut3YA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=fkqBw3BD5RLjSgApC7jY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932204AbeEWJwa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 05:52:30 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:5763 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932201AbeEWJw3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 23 May 2018 05:52:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,432,1520899200";
   d="scan'208";a="733297298"
Subject: Re: [PATCH v2] drm: fix off-by-one in logger
CC: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <stable@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <tony.cheng@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jordan Lazare <Jordan.Lazare@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>
References: <1527054785-5417-1-git-send-email-nmanthey@amazon.de>
 <1527056531-9568-1-git-send-email-nmanthey@amazon.de>
To: "Manthey, Norbert" <nmanthey@amazon.de>
From: Norbert Manthey <nmanthey@amazon.de>
Openpgp: preference=signencrypt
Autocrypt: addr=nmanthey@amazon.de; prefer-encrypt=mutual; keydata=
 xsFNBFoJQc0BEADM8Z7hB7AnW6ErbSMsYkKh4HLAPfoM+wt7Fd7axHurcOgFJEBOY2gz0isR
 /EDiGxYyTgxt5PZHJIfra0OqXRbWuLltbjhJACbu35eaAo8UM4/awgtYx3O1UCbIlvHGsYDg
 kXjF8bBrVjPu0+g55XizX6ot/YPAgmWTdH8qXoLYVZVWJilKlTqpYEVvarSn/BVgCbIsQIps
 K93sOTN9eJKDSqHvbkgKl9XG3WsZ703431egIpIZpfN0zZtzumdZONb7LiodcFHJ717vvd89
 3Hv2bYv8QLSfYsZcSnyU0NVzbPhb1WtaduwXwNmnX1qHJuExzr8EnRT1pyhVSqouxt+xkKbV
 QD9r+cWLChumg3g9bDLzyrOTlEfAUNxIqbzSt03CRR43dWgfgGiLDcrqC2b1QR886WDpz4ok
 xX3fdLaqN492s/3c59qCGNG30ebAj8AbV+v551rsfEba+IWTvvoQnbstc6vKJCc2uG8rom5o
 eHG/bP1Ug2ht6m/0uWRyFq9C27fpU9+FDhb0ZsT4UwOCbthe35/wBZUg72zDpT/h5lm64G6C
 0TRqYRgYcltlP705BJafsymmAXOZ1nTCuXnYAB9G9LzZcKKq5q0rP0kp7KRDbniirCUfp7jK
 VpPCOUEc3tS1RdCCSeWNuVgzLnJdR8W2h9StuEbb7hW4aFhwRQARAQABzSROb3JiZXJ0IE1h
 bnRoZXkgPG5tYW50aGV5QGFtYXpvbi5kZT7CwX0EEwEIACcFAloJQc0CGyMFCQlmAYAFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AACgkQZ+8yS8zN62ajmQ/6AlChoY5UlnUaH/jgcabyAfUC
 XayHgCcpL1SoMKvc2rCA8PF0fza3Ep2Sw0idLqC/LyAYbI6gMYavSZsLcsvY6KYAZKeaEriG
 7R6cSdrbmRcKpPjwvv4iY6G0DBTeaqfNjGe1ECY8u522LprDQVquysJIf3YaEyxoK/cLSb0c
 kjzpqI1P9Vh+8BQb5H9gWpakbhFIwbRGHdAF1roT7tezmEshFS0IURJ2ZFEI+ZgWgtl1MBwN
 sBt65im7x5gDo25h8A5xC9gLXTc4j3tk+3huaZjUJ9mCbtI12djVtspjNvDyUPQ5Mxw2Jwar
 C3/ZC+Nkb+VlymmErpnEUZNltcq8gsdYND4TlNbZ2JhD0ibiYFQPkyuCVUiVtimXfh6po9Yt
 OkE0DIgEngxMYfTTx01Zf6iwrbi49eHd/eQQw3zG5nn+yZsEG8UcP1SCrUma8p93KiKOedoL
 n43kTg4RscdZMjj4v6JkISBcGTR4uotMYP4M0zwjklnFXPmrZ6/E5huzUpH9B7ZIe/SUu8Ur
 xww/4dN6rfqbNzMxmya8VGlEQZgUMWcck+cPrRLB09ZOk4zq9i/yaHDEZA1HNOfQ9UCevXV5
 7seXSX7PCY6WDAdsT3+FuaoQ7UoWN3rdpb+064QKZ0FsHeGzUd7MZtlgU4EKrh25mTSNZYRs
 nTz2zT/J33fOwU0EWglBzQEQAKioD1gSELj3Y47NE11oPkzWWdxKZdVr8B8VMu6nVAAGFRSf
 Dms4ZmwGY27skMmOH2srnZyTfm9FaTKr8RI+71Fh9nfB9PMmwzA7OIY9nD73/HqPywzTTleG
 MlALmnuY6xFRSDmqmvxDHgWyzB4TgPWt8+hW3+TJKCx2RgLAdSuULZla4lia+NlS8WNRUDGK
 sFJCCB3BW5I/cocfpBEUqLbbmnPuD9UKpEnFcYWD9YaDNcBTjSc7iDsvtpdrBXg5VETOz/TQ
 /CmVs9h/5zug8O4bXxHEEJpCAxs4cGKxowBqx/XJfkwdWeo/LdaeR+LRbXvq4A32HSkyj9sV
 vygwt2OFEk493JGik8qtAA/oPvuqVPJGacxmZ7zKR12c0mnKCHiexFJzFbC7MSiUhhe8nNiM
 p6Sl6EZmsTUXhV2bd2M12Bqcss3TTJ1AcW04T4HYHVCSxwl0dVfcf3TIaH0BSPiwFxz0FjMk
 10umoRvUhYYoYpPFCz8dujXBlfB8q2tnHltEfoi/EIptt1BMNzTYkHKArj8Fwjf6K+nQ3a8p
 1cWfkYpA5bRqbhbplzpa0u1Ex0hZk6pka0qcVgqmH31O2OcSsqeKfUfHkzj3Q6dmuwm1je/f
 HWH9N1gDPEp1RB5bIxPnOG1Z4SNl9oVQJhc4qoJiqbvkciivYcH7u2CBkboFABEBAAHCwWUE
 GAEIAA8FAloJQc0CGwwFCQlmAYAACgkQZ+8yS8zN62YU9Q//WTnN28aBX1EhDidVho80Ql2b
 tV1cDRh/vWTcM4qoM8vzW4+F/Ive6wDVAJ7zwAv8F8WPzy+acxtHLkyYk14M6VZ1eSy0kV0+
 RZQdQ+nPtlb1MoDKw2N5zhvs8A+WD8xjDIA9i21hQ/BNILUBINuYKyR19448/41szmYIEhuJ
 R2fHoLzNdXNKWQnN3/NPTuvpjcrkXKJm2k32qfiys9KBcZX8/GpuMCc9hMuymzOr+YlXo4z4
 1xarEJoPOQOXnrmxN4Y30/qmf70KHLZ0GQccIm/o/XSOvNGluaYv0ZVJXHoCnYvTbi0eYvz5
 OfOcndqLOfboq9kVHC6Yye1DLNGjIVoShJGSsphxOx2ryGjHwhzqDrLiRkV82gh6dUHKxBWd
 DXfirT8a4Gz/tY9PMxan67aSxQ5ONpXe7g7FrfrAMe91XRTf50G3rHb8+AqZfxZJFrBn+06i
 p1cthq7rJSlYCqna2FedTUT+tK1hU9O0aK4ZYYcRzuTRxjd4gKAWDzJ1F/MQ12ftrfCAvs7U
 sVbXv2TndGIleMnheYv1pIrXEm0+sdz5v91l2/TmvkyyWT8s2ksuZis9luh+OubeLxHq090C
 hfavI9WxhitfYVsfo2kr3EotGG1MnW+cOkCIX68w+3ZS4nixZyJ/TBa7RcTDNr+gjbiGMtd9
 pEddsOqYwOs=
Message-ID: <414c65ce-9fbb-8601-c65c-f7a602ba408c@amazon.de>
Date: Wed, 23 May 2018 11:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1527056531-9568-1-git-send-email-nmanthey@amazon.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
X-Originating-IP: [10.43.161.149]
X-ClientProxiedBy: EX13D12UWC004.ant.amazon.com (10.43.162.182) To
 EX13D02EUB001.ant.amazon.com (10.43.166.150)
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

RGVhciBhbGwsCgpJIGp1c3Qgbm90aWNlZCB0aGF0IHJlcGx5aW5nIHRvIG15IGVhcmxpZXIgZW1h
aWwgdGhyZWFkIGZhaWxlZCwgYW5kIHRoYXQKSSB0aGVyZWJ5IGNyZWF0ZWQgYSBuZXcgdGhyZWFk
LiBUaGUgb3JpZ2luYWwgdGhyZWFkIGlzIHRoZSBmb2xsb3dpbmcgb25lOgpodHRwczovL2xrbWwu
b3JnL2xrbWwvMjAxOC8yLzE2LzI3NAoKSSBhbSBzb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbiEKCkJl
c3QsCk5vcmJlcnQKCgpPbiAwNS8yMy8yMDE4IDA4OjIyIEFNLCBOb3JiZXJ0IE1hbnRoZXkgd3Jv
dGU6Cj4gVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gd2lsbCBsZWFrIGEgYnl0ZSB0byB0aGUg
bG9nIHZpYSBtZW1tb3ZlLiBUaGUKPiBzcGVjaWZpZWQgMjcgYnl0ZXMgYXJlIG9mZi1ieS1vbmUs
IGFzIHRoZSBwYXlsb2FkIGlzIDI1IGJ5dGVzLCBhbmQgdGhlCj4gdGVybWluYXRpb24gY2hhcmFj
dGVyIGlzIG9ubHkgb25lIGJ5dGUgbGFyZ2UuIFRvIGF2b2lkIHRoaXMsIGZhY3RvciBvdXQKPiB0
aGUgZXJyb3IgbWVzc2FnZSwgYW5kIGZ1cnRoZXJtb3JlIG1ha2UgdGhlIHNlY29uZCBwYXJhbWV0
ZXIgb2YgdGhlCj4gYXBwZW5kX2VudHJ5IGZ1bmN0aW9uIGNvbnN0Lgo+Cj4gVGhlIGZ1bGwgdHJh
Y2UgaXMgYXMgZm9sbG93czoKPgo+IEluIGZ1bmN0aW9uIOKAmG1lbW1vdmXigJksCj4gICAgZnJv
bSDigJhhcHBlbmRfZW50cnnigJkgYXQKPiAgICAgICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9iYXNpY3MvbG9nZ2VyLmM6MjU3OjIsCj4gICAgZnJvbSDigJhkbV9sb2dnZXJfYXBw
ZW5kX3Zh4oCZIGF0Cj4gICAgICAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFz
aWNzL2xvZ2dlci5jOjM0ODo0Cj4gICAgZGV0ZWN0ZWQgcmVhZCBiZXlvbmQgc2l6ZSBvZiBvYmpl
Y3QgcGFzc2VkIGFzIDJuZCBwYXJhbWV0ZXIKPgo+IFNpZ25lZC1vZmYtYnk6IE5vcmJlcnQgTWFu
dGhleSA8bm1hbnRoZXlAYW1hem9uLmRlPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvYmFzaWNzL2xvZ2dlci5jIHwgNiArKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmFzaWNzL2xvZ2dlci5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2Jhc2ljcy9sb2dnZXIuYwo+IGluZGV4IDMxYmVlMDUuLjZiYThkMGMgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jhc2ljcy9sb2dnZXIu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iYXNpY3MvbG9nZ2VyLmMK
PiBAQCAtMjQ0LDcgKzI0NCw3IEBAIHN0YXRpYyB2b2lkIGxvZ19oZWFkaW5nKHN0cnVjdCBsb2df
ZW50cnkgKmVudHJ5KQo+ICAKPiAgc3RhdGljIHZvaWQgYXBwZW5kX2VudHJ5KAo+ICAJCXN0cnVj
dCBsb2dfZW50cnkgKmVudHJ5LAo+IC0JCWNoYXIgKmJ1ZmZlciwKPiArCQljb25zdCBjaGFyICpi
dWZmZXIsCj4gIAkJdWludDMyX3QgYnVmX3NpemUpCj4gIHsKPiAgCWlmICghZW50cnktPmJ1ZiB8
fAo+IEBAIC0zNDYsNyArMzQ2LDkgQEAgdm9pZCBkbV9sb2dnZXJfYXBwZW5kX3ZhKAo+ICAJCWlm
IChzaXplIDwgTE9HX01BWF9MSU5FX1NJWkUgLSAxKSB7Cj4gIAkJCWFwcGVuZF9lbnRyeShlbnRy
eSwgYnVmZmVyLCBzaXplKTsKPiAgCQl9IGVsc2Ugewo+IC0JCQlhcHBlbmRfZW50cnkoZW50cnks
ICJMT0dfRVJST1IsIGxpbmUgdG9vIGxvbmdcbiIsIDI3KTsKPiArCQkJc3RhdGljIGNvbnN0IGNo
YXIgbXNnW10gPSAiTE9HX0VSUk9SLCBsaW5lIHRvbyBsb25nXG4iOwo+ICsKPiArCQkJYXBwZW5k
X2VudHJ5KGVudHJ5LCBtc2csIHNpemVvZihtc2cpKTsKPiAgCQl9Cj4gIAl9Cj4gIH0KCkFtYXpv
biBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNo
ZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUy
ODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0
OTE3MyBCCg==
