Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3984029-1518392477-2-5176927609318188584
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518392476; b=nis/A5yCgKYuVB6PWYBn0VlsN3TwI+GhR53LZI+LXv2Pz96
    KxLUPxPzkRUCitQzmbTO6VxT9My3e7fjeGApUY4+inEGpgLs6MtDngj88re4qB7r
    n0coXjstI5QR+fhUkYr+Y3Z9W1wJ+A4xPF6cvsrfrBfh+Pwiz6gStioABydFX7MM
    nCXCU9To1fD8vBzq8jYR3bzJe7arMhY3qAym41/PeO/2MyoBHnTrM1BvZvNdTlxT
    7OmI5q3N3jSzf+Rj0t69yQQnUme9MijMCbbAew6qlUMiROQOhxsyoRHXH0PjNYDD
    8T04bzbmjQEmJBzcEEXlVUZ+fxS4hxw7OV85faQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1518392476; bh=DL6ltU5B
    32DtJ8ebIq+6yeblTHWx024nck3BcLGS5fo=; b=vEL0lF2Fl4bTs9AvYSnhYWYE
    nWaSfkhJA4oFPrFhPZp0OwBxiMxloj+nVf0zdzIhiSwGWyZtTvnbSa8Hx/3rVaiL
    khPMSlxnbpQcVuPfWXAXFTbbbek11BPpfjUccEvNF/T7hVkX9tyZMr1XAdM5kAfr
    QzWfypIvTk1D1vHL3KQs8T0A+QMD/4V0dXmy0cvn3OQoYvRYzXPwuQIsQ3wRya0g
    xsukcPLSv2igLxs2EPyFILgZeeR53i5WC4FgJBaCwGYHzu2NRGTsKBQtLbX7p+rY
    yRejEnSWGLqlz0qb8QaRXq/JowncPj83d+GgzTyBdzjpqzlGLipxm+ljuUvYnQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=QDR1SOUE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=QDR1SOUE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeBKXlO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 18:41:14 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:61931 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbeBKXlN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 18:41:13 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180211234111epoutp016fabc9e7db9af6bce8feb988ef7c2712~Saehd7har0392903929epoutp01r
X-AuditID: b6c32a38-ac3ff70000001054-11-5a80d496dc2e
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A80D497.80202@samsung.com>
Date: Mon, 12 Feb 2018 08:41:11 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] extcon: int3496: process id-pin first so that we
 start with the right status
In-reply-to: <5A796400.20905@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmnu60Kw1RBo0TdSzeHJ/OZHF51xw2
        i9uNK9gsFmx8xOjA4vF+31U2j74tqxg9Pm+SC2COSrXJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        ijY0NNIzNDDXMzIy0jMxjrUyMgUqSUjNuH1nC2PBLfaKE7M/sDUwzmHrYuTkkBAwkfg99SdL
        FyMXh5DADkaJvof/WCGc74wSL9p2M3YxcoBVdT+Jg4jvZpRoPD2dBaSbV0BQ4sfkeywgNcwC
        8hJHLmWDhJkFNCVefJkENfQeo8TxjS+ZIOo1JH53fmcFsVkEVCWmHFgAFmcT0JLY/+IG2EX8
        AooSV388ZgSxRQUiJHbO/8YOYosIBEnc+L6CFWKXhUT7flOQsLBAmkTX+hfMIDYn0N6Ji7+y
        g+yVEFjBJvH1z0VWiC9dJM5v+cQMYQtLvDq+hR3iL2mJS0dtIerbGSXa985jhnCmMEqcu36P
        CaLBWOLZwi4miM/4JN597WGFaOaV6GgTgijxkFj1tIsFwnaU+HP/KtTzK4Eh+v8k0wRGuVlI
        4TULEV6zkMJrASPzKkax1ILi3PTUYsMCE73ixNzi0rx0veT83E2M4OSlZbGDcc85n0OMAhyM
        Sjy8DtUNUUKsiWXFlbmHGCU4mJVEeDsvAIV4UxIrq1KL8uOLSnNSiw8xmgKDeyKzlGhyPjCx
        5pXEG5pYGpiYGQFTl6WhoZI4b0CAS5SQQHpiSWp2ampBahFMHxMHp1QD44QDMt3JZUbnzp6r
        fjf187XFedPtRJl9vwrqzf+xU/lMTYza+vw1y4sWz2hbHlJf8FRwUt/N9b2hezlY14jfbqx7
        JJ2ZE7Zqdpz3z1xds7dJn1m0q3Zu3GMXrrbqDLuTYo3FqYhyhjLJP70HDr/Zz31wTaOqcKi/
        z9nwDX16hbqTn8ea1GkrKLEUZyQaajEXFScCACzVHbF0AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t9jAd2pVxqiDJ681bJ4c3w6k8XlXXPY
        LG43rmCzWLDxEaMDi8f7fVfZPPq2rGL0+LxJLoA5issmJTUnsyy1SN8ugSvj9p0tjAW32CtO
        zP7A1sA4h62LkYNDQsBEovtJXBcjF4eQwE5GiQsvFjJ2MXJy8AoISvyYfI8FpIZZQF7iyKVs
        CFNdYsqUXJAKIYEHjBJHf8RBVGtI/O78zgpiswioSkw5sIAJxGYT0JLY/+IGG4jNL6AocfXH
        Y0aQMaICERLdJypBwiICARI/T/WzQ0y3kGjfbwoSFhZIkzh3ZjYLxKbVjBJzttmB2JwCmhIT
        F39ln8AoMAvJmbMQzpyFcOYCRuZVjJKpBcW56bnFRgWGeanlesWJucWleel6yfm5mxiBwbrt
        sFbfDsb7S+IPMQpwMCrx8DpUN0QJsSaWFVfmHmKU4GBWEuHtvAAU4k1JrKxKLcqPLyrNSS0+
        xCjNwaIkzns771ikkEB6YklqdmpqQWoRTJaJg1OqgdEyWXRHjSLz4Vmtl3675Ird0uZo3zQ3
        UbyGLeDA7XJHhztqZtVv4k/+XvyUQftGhIT4x7k3l0cr5i79vvdwhLat69YpDhXvbP7IPJxY
        fcezI06jjkXVocbajvcvh980ofnmb4/fNhNd2Fp96mVV0banias2TmL8mvZyouHDH6fKbDTF
        PMO63iqxFGckGmoxFxUnAgBLTu+1UgIAAA==
X-CMS-MailID: 20180211234109epcas1p41e01040f780eb00494c83bf086df47ee
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180206081056epcas2p19485991e157843cf2e016a6dfed41027
X-RootMTR: 20180206081056epcas2p19485991e157843cf2e016a6dfed41027
References: <CGME20180206081056epcas2p19485991e157843cf2e016a6dfed41027@epcas2p1.samsung.com>
        <20180206081051.10785-1-hdegoede@redhat.com> <5A796400.20905@samsung.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 02월 06일 17:14, Chanwoo Choi wrote:
> On 2018년 02월 06일 17:10, Hans de Goede wrote:
>> Some other drivers may be waiting for our extcon to show-up (exiting their
>> probe methods with -EPROBE_DEFER until we show up).
>>
>> These drivers will typically get the cable state directly after getting
>> the extcon, this commit changes the int3496 code to process the id-pin
>> before registering the extcon, so that other drivers see the correct state
>> right away.
>>
>> Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI ... driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/extcon/extcon-intel-int3496.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Applied it. Thanks.
> 

This patch had the bug reported by Hans.
Please ignore what I applied patch.
I don't apply it and I'll wait v3 patch.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
