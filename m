Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1992793-1525124313-2-3892721026974661825
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525124312; b=PpIry+corl/3NkHwct34fJwgy5YhK6z19uQ4R2pNEYYVDK75Hn
    aVu66COTyIqmoLam4ZgC8+8NyQnDiKNU8ifeXGvpvhSdNR+Dq4Rb9GhEHdZhLVSE
    TXskUCcvkLIkofUyDf97ePRqRqC+Ne1kHXaS+o3X8lW5D8mMZ448tgRe29O9Uxvj
    e69UNXIwpCoEDZixi294fKtZuJYQWt6anIJnsrnzISeHHgvCas27ofgybijWkNIa
    Rz9tKjWtnU/I1O2t/2GQr4J0EWEmlWCjhwbmU17pD3tkmJr3ZruZGBy2/MK70s4i
    mIzkoBHTOaQzO2eFhRuB4LW/511luLId5MVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1525124312; bh=UAHAZVu26qz29Gh2UHoWARmfzihCNm4D8rl7Zpa4kY
    c=; b=W9EWYy+5X1/f3HzWG6u8gYiFEkZFX7iiO7vpg4BfmhiNPphrfyEaVNuS87
    WJFcC0JMZ71HR7kS1RIbajNS1GnP+35CqsfjpN9pDq6TpgvKNqpUnjAt20b+XRxb
    DJfq7kMgOt9hmDeA5MH3tie+YBoUSnL0qYJW1v2JJRoZhHNmll7KdLvmSXIuQU5/
    z3gnRcaeJ8mHYlDmNz+cdpg3aD7ixR5DNRyc6TNu2HkvkirOBfK6adYy39Tl91pq
    yz4yuo9eEcNxo7dXNcVetRAxcC7RNMpbxr+f2KpeDWOc46bSCyorNUldCTBw/Pf7
    l5dmJklal8xQZSeVSJZscKEdFxHg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=cHVxodus x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=cHVxodus x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfETocqMxInAFZZgAk86y3/a4hvfkRZzeUsUYvYsJ1K2BReSfBN31ouyj/IHyS/cqb1us5rhXjTZlg7NoqOfevTM7vpj5RlnsDAl8IADhfydk6CpqKGN9
    GwlpmSQI03XU7RTesOOjJ8R1axOAcEyBgSfnV2jbPgrBJ2xbWTQi+2ntdivRHZNv/QoMsNPBAVpfZPVdVc8Biq+gEgjEhEPEptLS3FjkZmG7OqMmaLJYZ1lr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9
    a=h4Hiuis-jC3hXw5SU-EA:9 a=QEXdDO2ut3YA:10 a=hL14vO_61k9AX_7G29cA:9
    a=ONNS8QRKHyMA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbeD3Vi3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 17:38:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37214 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeD3Vi1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 30 Apr 2018 17:38:27 -0400
Subject: Re: [PATCH 1/6] xen: Add RING_COPY_RESPONSE()
To: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
        <marmarek@invisiblethingslab.com>
Cc: xen-devel@lists.xenproject.org, stable@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <ba8ed01b01a81d79f6d1c59e08a318dc0309a95d.1525122026.git-series.marmarek@invisiblethingslab.com>
 <7bd2ff07-9d29-8dea-6f55-5ff24ddd433c@oracle.com>
 <20180430212719.GF1124@mail-itl>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 xsFNBFH8CgsBEAC0KiOi9siOvlXatK2xX99e/J3OvApoYWjieVQ9232Eb7GzCWrItCzP8FUV
 PQg8rMsSd0OzIvvjbEAvaWLlbs8wa3MtVLysHY/DfqRK9Zvr/RgrsYC6ukOB7igy2PGqZd+M
 MDnSmVzik0sPvB6xPV7QyFsykEgpnHbvdZAUy/vyys8xgT0PVYR5hyvhyf6VIfGuvqIsvJw5
 C8+P71CHI+U/IhsKrLrsiYHpAhQkw+Zvyeml6XSi5w4LXDbF+3oholKYCkPwxmGdK8MUIdkM
 d7iYdKqiP4W6FKQou/lC3jvOceGupEoDV9botSWEIIlKdtm6C4GfL45RD8V4B9iy24JHPlom
 woVWc0xBZboQguhauQqrBFooHO3roEeM1pxXjLUbDtH4t3SAI3gt4dpSyT3EvzhyNQVVIxj2
 FXnIChrYxR6S0ijSqUKO0cAduenhBrpYbz9qFcB/GyxD+ZWY7OgQKHUZMWapx5bHGQ8bUZz2
 SfjZwK+GETGhfkvNMf6zXbZkDq4kKB/ywaKvVPodS1Poa44+B9sxbUp1jMfFtlOJ3AYB0WDS
 Op3d7F2ry20CIf1Ifh0nIxkQPkTX7aX5rI92oZeu5u038dHUu/dO2EcuCjl1eDMGm5PLHDSP
 0QUw5xzk1Y8MG1JQ56PtqReO33inBXG63yTIikJmUXFTw6lLJwARAQABzTNCb3JpcyBPc3Ry
 b3Zza3kgKFdvcmspIDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT7CwXgEEwECACIFAlH8
 CgsCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEIredpCGysGyasEP/j5xApopUf4g
 9Fl3UxZuBx+oduuw3JHqgbGZ2siA3EA4bKwtKq8eT7ekpApn4c0HA8TWTDtgZtLSV5IdH+9z
 JimBDrhLkDI3Zsx2CafL4pMJvpUavhc5mEU8myp4dWCuIylHiWG65agvUeFZYK4P33fGqoaS
 VGx3tsQIAr7MsQxilMfRiTEoYH0WWthhE0YVQzV6kx4wj4yLGYPPBtFqnrapKKC8yFTpgjaK
 jImqWhU9CSUAXdNEs/oKVR1XlkDpMCFDl88vKAuJwugnixjbPFTVPyoC7+4Bm/FnL3iwlJVE
 qIGQRspt09r+datFzPqSbp5Fo/9m4JSvgtPp2X2+gIGgLPWp2ft1NXHHVWP19sPgEsEJXSr9
 tskM8ScxEkqAUuDs6+x/ISX8wa5Pvmo65drN+JWA8EqKOHQG6LUsUdJolFM2i4Z0k40BnFU/
 kjTARjrXW94LwokVy4x+ZYgImrnKWeKac6fMfMwH2aKpCQLlVxdO4qvJkv92SzZz4538az1T
 m+3ekJAimou89cXwXHCFb5WqJcyjDfdQF857vTn1z4qu7udYCuuV/4xDEhslUq1+GcNDjAhB
 nNYPzD+SvhWEsrjuXv+fDONdJtmLUpKs4Jtak3smGGhZsqpcNv8nQzUGDQZjuCSmDqW8vn2o
 hWwveNeRTkxh+2x1Qb3GT46uzsFNBFH8CgsBEADGC/yx5ctcLQlB9hbq7KNqCDyZNoYu1HAB
 Hal3MuxPfoGKObEktawQPQaSTB5vNlDxKihezLnlT/PKjcXC2R1OjSDinlu5XNGc6mnky03q
 yymUPyiMtWhBBftezTRxWRslPaFWlg/h/Y1iDuOcklhpr7K1h1jRPCrf1yIoxbIpDbffnuyz
 kuto4AahRvBU4Js4sU7f/btU+h+e0AcLVzIhTVPIz7PM+Gk2LNzZ3/on4dnEc/qd+ZZFlOQ4
 KDN/hPqlwA/YJsKzAPX51L6Vv344pqTm6Z0f9M7YALB/11FO2nBB7zw7HAUYqJeHutCwxm7i
 BDNt0g9fhviNcJzagqJ1R7aPjtjBoYvKkbwNu5sWDpQ4idnsnck4YT6ctzN4I+6lfkU8zMzC
 gM2R4qqUXmxFIS4Bee+gnJi0Pc3KcBYBZsDK44FtM//5Cp9DrxRQOh19kNHBlxkmEb8kL/pw
 XIDcEq8MXzPBbxwHKJ3QRWRe5jPNpf8HCjnZz0XyJV0/4M1JvOua7IZftOttQ6KnM4m6WNIZ
 2ydg7dBhDa6iv1oKdL7wdp/rCulVWn8R7+3cRK95SnWiJ0qKDlMbIN8oGMhHdin8cSRYdmHK
 kTnvSGJNlkis5a+048o0C6jI3LozQYD/W9wq7MvgChgVQw1iEOB4u/3FXDEGulRVko6xCBU4
 SQARAQABwsFfBBgBAgAJBQJR/AoLAhsMAAoJEIredpCGysGyfvMQAIywR6jTqix6/fL0Ip8G
 jpt3uk//QNxGJE3ZkUNLX6N786vnEJvc1beCu6EwqD1ezG9fJKMl7F3SEgpYaiKEcHfoKGdh
 30B3Hsq44vOoxR6zxw2B/giADjhmWTP5tWQ9548N4VhIZMYQMQCkdqaueSL+8asp8tBNP+TJ
 PAIIANYvJaD8xA7sYUXGTzOXDh2THWSvmEWWmzok8er/u6ZKdS1YmZkUy8cfzrll/9hiGCTj
 u3qcaOM6i/m4hqtvsI1cOORMVwjJF4+IkC5ZBoeRs/xW5zIBdSUoC8L+OCyj5JETWTt40+lu
 qoqAF/AEGsNZTrwHJYu9rbHH260C0KYCNqmxDdcROUqIzJdzDKOrDmebkEVnxVeLJBIhYZUd
 t3Iq9hdjpU50TA6sQ3mZxzBdfRgg+vaj2DsJqI5Xla9QGKD+xNT6v14cZuIMZzO7w0DoojM4
 ByrabFsOQxGvE0w9Dch2BDSI2Xyk1zjPKxG1VNBQVx3flH37QDWpL2zlJikW29Ws86PHdthh
 Fm5PY8YtX576DchSP6qJC57/eAAe/9ztZdVAdesQwGb9hZHJc75B+VNm4xrh/PJO6c1THqdQ
 19WVJ+7rDx3PhVncGlbAOiiiE3NOFPJ1OQYxPKtpBUukAlOTnkKE6QcA4zckFepUkfmBV1wM
 Jg6OxFYd01z+a+oL
Message-ID: <cb0c0525-dac2-c26f-77ed-21128ecb623d@oracle.com>
Date: Mon, 30 Apr 2018 17:41:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430212719.GF1124@mail-itl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vNzrufIOtU6vFxFMAPnjOdrkLyvUdqrgl"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8879 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300208
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vNzrufIOtU6vFxFMAPnjOdrkLyvUdqrgl
Content-Type: multipart/mixed; boundary="V9HnKD6siNJ7JnWUPpd02LYyzf9t7aucO";
 protected-headers="v1"
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: =?UTF-8?Q?Marek_Marczykowski-G=c3=b3recki?=
 <marmarek@invisiblethingslab.com>
Cc: xen-devel@lists.xenproject.org, stable@vger.kernel.org,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 open list <linux-kernel@vger.kernel.org>
Message-ID: <cb0c0525-dac2-c26f-77ed-21128ecb623d@oracle.com>
Subject: Re: [PATCH 1/6] xen: Add RING_COPY_RESPONSE()
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <ba8ed01b01a81d79f6d1c59e08a318dc0309a95d.1525122026.git-series.marmarek@invisiblethingslab.com>
 <7bd2ff07-9d29-8dea-6f55-5ff24ddd433c@oracle.com>
 <20180430212719.GF1124@mail-itl>
In-Reply-To: <20180430212719.GF1124@mail-itl>

--V9HnKD6siNJ7JnWUPpd02LYyzf9t7aucO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US

T24gMDQvMzAvMjAxOCAwNToyNyBQTSwgTWFyZWsgTWFyY3p5a293c2tpLUfDs3JlY2tpIHdy
b3RlOgo+IE9uIE1vbiwgQXByIDMwLCAyMDE4IGF0IDA1OjI1OjUyUE0gLTA0MDAsIEJvcmlz
IE9zdHJvdnNreSB3cm90ZToKPj4gQWxzbywgcGVyaGFwcyB0aGUgdHdvIGNhbiBiZSBjb2xs
YXBzZWQgdG9nZXRoZXIsIGFsb25nIHRoZSBsaW5lcyBvZgo+Pgo+PiAjZGVmaW5lIFJJTkdf
Q09QWV8oYWN0aW9uLCBfciwgX2lkeCwgX21zZykgZG8ge8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPj4gwqDCoMKgwqDCoMKgwqAgLyog
VXNlIHZvbGF0aWxlIHRvIGZvcmNlIHRoZSBjb3B5IGludG8gX21zZy4gKi/CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4+IMKgwqDCoMKgwqDCoMKgICooX21zZykgPSAq
KHZvbGF0aWxlIHR5cGVvZihfbXNnKSlSSU5HX0dFVF8jI2FjdGlvbihfciwgX2lkeCk7wqDC
oCBcCj4+IH0gd2hpbGUgKDApCj4+Cj4+ICNkZWZpbmUgUklOR19DT1BZX1JFUVVFU1QoX3Is
IF9pZHgsIF9yZXEpwqAgUklOR19DT1BZXyhSRVFVRVNULCBfciwgX2lkeCwKPj4gX3JlcSkK
Pj4gI2RlZmluZSBSSU5HX0NPUFlfUkVTUE9OU0UoX3IsIF9pZHgsIF9yc3ApwqAgUklOR19D
T1BZXyhSRVNQT05TRSwgX3IsCj4+IF9pZHgsIF9yc3ApCj4+Cj4+Cj4+IChJIGhhdmUgbm90
IHRyaWVkIHRvIGNvbXBpbGUgdGhpcyBzbyBpdCBtYXkgd2VsbCBiZSB3cm9uZykKPiBJdCB3
b3JrcywgdGhhbmtzIDopCj4gSSdsbCB3YWl0IHdpdGggdjIgdW50aWwgSSBnZXQgZmVlZGJh
Y2sgb24gb3RoZXIgcGF0Y2hlcy4KPgoKCk9oLCBhbmQgb25lIG1vcmUgdGhpbmcgLS0tIHRo
ZSBjYW5vbmljYWwgdmVyc2lvbiBvZiB0aGlzIGZpbGUgbGl2ZXMgaW4KWGVuIChpbmNsdWRl
L3B1YmxpYy9pby9yaW5nLmgpIHNvIGl0IG5lZWRzIGZpcnN0IHRvIGJlIGFjY2VwdGVkIGJ5
IFhlbgptYWludGFpbmVycy4KCi1ib3Jpcwo=

--V9HnKD6siNJ7JnWUPpd02LYyzf9t7aucO--

--vNzrufIOtU6vFxFMAPnjOdrkLyvUdqrgl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEExAVKDNg/TOdD61Yyit52kIbKwbIFAlrnjXEACgkQit52kIbK
wbIRvg/8Dud/7NIaJ+XBtdzL3C7Qu5zfGAM+8E0UATljwYRBiMlam9aKnu2Cycgv
SJEpVVJhDcAfCB93/rLeN9okwkJrqxpQcl9+8hghwsmbhM1+CM6YreFqzEc8iLJp
Ni0qu2HKq5Gp9z8Pdxw7/wq6GhWwHCRAwK6ODhshV+I9SdOX0qmaTdhPWttaj4iW
hs3+jQZr2t8rHWypPlx/RX43LENZVIdcOzwp6meYycxm1Hf6RZvHkj/RrP98m7jl
WDHZ3l+oQIE8Yht5FJF3YyoyWroUOMgYlIe5/Nogb8QpbbYN+9MnyejrbhXLkNTT
GM+nKe3lmPnc/JKnAPHMTM0sGAm5KpsN39Zsg4e985rZPitr+6B+Cu1qbGrWTjPc
xO8C45p9K62Mr+iD9dV6Le1UVoslhGeCNt8naw4E1rxZbI1d+dDknV0ZAaI+MO+s
wV3TooUX3vhD8UTbYUy9j44qAfqfI+J0PYSpxJa51jqmgXntdKfrOvKuDdfGz04+
GeIr02KaxJ6cA907+Dqkqq372XuBFjdpbAzxq33nMnkt0lvsMJWHmBJddTwTwZ9l
yEu0UCmd4N/re09vYNqelzrjz+3T7Sjg+Wk995xdZZcR7FF+oPTLUU6zuIx0IoYS
+5Sp1huBpR0g4z9G8zznauXXjBGJoWF/04SnnJ3XzkGO1ayl5NU=
=VPEN
-----END PGP SIGNATURE-----

--vNzrufIOtU6vFxFMAPnjOdrkLyvUdqrgl--
