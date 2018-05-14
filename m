Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526282521-2-1791673790809813961
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='se',
  MailFrom='org', XOriginatingCountry='SE'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526282521; b=lgj381698RRjXUmTtJHIx8tNaHfeR07tE8W6MZha4PTyracHue
    feXgU5tHyeSzytkYs7WJK7hFoXDUL4xE5QdgPj0OnhAfetP6EEmkMPxIEZVjfUOG
    HeNHNE+4C2oy0AFR11GjS/yPUTBdHjUrPOjGyY+zVI5Pu10ONnkxAGSnILAONh5a
    cJIagdB/3sg3wzwOsZJ86j6FhCQUvS3GoXMVILSq9e4V2fsrZUkpH6QcD/2WwYaK
    5chO5GYOQhFx1MPPZOYSwpo+vvemB/1NwpFXjZNfpiZVsZnzLbXGjpq7Vi+2NLR8
    hpzFVr8mpwnIcSpgmQeiQklr5XlKteaO76WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526282521;
    bh=+80VRNq+sLO1D+1H9e3wnPBQz3waAPSRkhFynhVGqIM=; b=YBIDCiuoCuFC
    gF8C/5Jec3C/V7V45axjPN/5ZnnctVVdoxk/YgSbJ668/AIO2qiemObhFWnQU6N6
    FZkWuqbLoHnbu1C2BSDOPxpEVVfnth09VvvlqVNaR4ygigBXubulhuxXCc7sil1d
    fn2EOPLDqnoUV1FhJAGX4iLugLllm7hkPqDxsCZOC4cmcYaGcim4cO9qF0gnHzt1
    z91QL8Sz4CtsKrgH68Y7fDEehk50arygZy3vtWXfv0yvHh9Jn05C3Fi78It0Pf0Q
    vMke8GZT5FyjqsZ7adocHa9G8Jr8mp8F7d7UzsbyB9XlVM0U4orvaPf/zkhU6MZ3
    3RlxWiBTyA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=axentia.se header.i=@axentia.se header.b=WVM5JNfI x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=axentia.se;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=axentia.se header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=axentia.se header.i=@axentia.se header.b=WVM5JNfI x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=axentia.se;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=axentia.se header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCKekMIidIhH/Os9pMl5mHnOhn/J8N37rR+hoFV65dTR5TtbJXNFjYkO/JDoXiGHa7SneE/7FCE6ddSaJKjEivbLNh4HtfmEqJc+gtgxQosuitlnkCkz
    qhhUDBJEk/CPXkwuQp86ZBpuKUpIBny8mRi5MhwZsPeholotlZfcq1xG72M0fHESn40fURMslkxZZ6ZSAcjwPYnEXvPWrMqufwB0QcKiaggm5x+mXoasPWYR
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=ZLfmkL5D54wA:10 a=c_ceevn7C1wA:10 a=FZ-paitokdoA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=ikY9E9ch9_EA:10 a=LpQP-O61AAAA:8 a=NEAV23lmAAAA:8
    a=VwQbUJbxAAAA:8 a=tJbPsATxX4B2aaJvHa0A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeENHVs (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:21:48 -0400
Received: from mail-eopbgr00092.outbound.protection.outlook.com ([40.107.0.92]:7769
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754009AbeENHVn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 14 May 2018 03:21:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
To: yossim@codeaurora.org
Cc: Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:CHIPIDEA USB HIGH SPEED DUAL ROLE CONTROLLER"
        <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, robh@kernel.org,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        Stephen Boyd <stephen.boyd@linaro.org>
References: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
 <ec1c44d7-45a8-a27e-5c45-717b87d3b252@axentia.se>
 <e75dff8424debcabd79f36faf3b23aaf@codeaurora.org>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4abbe781-f488-b876-06a0-5521736c4d6c@axentia.se>
Date: Mon, 14 May 2018 09:21:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e75dff8424debcabd79f36faf3b23aaf@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR07CA0028.eurprd07.prod.outlook.com
 (2603:10a6:7:66::14) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:7mwnldyktd06v1Rkbrz2EQLzCjwdGtOr4YOTBpbJgXli6mIbwJgQd2qJQCfeWRUd2TJgSa8obcJCRsk9yU6XRXsMbCmNzybYAaqVjC022Nhebp18cZqi6Iz5Mve8d7Hjamidks7YmV1rXcMX6kE+tE5Z/Y53AVfRHEtLjLiLYEUv4J5XIyTSryw921lQ6O7+iv6M/i0jo+rQUz1iEh4Pi7ZFQOfmuxL+wP0zYS50fLseM2gNdJ1VKv6etL3JzKc2;25:sCnSzaUHJv+p1zqm7HoCxdaJeeHuX2by7WgLR5yCezswP2hZqgcg4rAZhu3lFJoKz45xdAm7Bwg8Y/TPk6pSagRHxLje2wPGFObdm1tXPOy+V6BptDFde57b3LwYKewky4LrAasmY8yMXLbQjPvAzGFCJk4uMa3c4D5fShAkqUHLGKZe7pUEOk73u8mr9y9Xc1XwkIod8ehXPwO29/1JwKiOb/syiS7/u5MwesB2T7u5nxwC9kJzhvdNuLegfIQ8ByJ4v6zDBANz0sH/P4/N4nHXBfE6jTby+dxoyVfjUz0ir/TJNXwGXBdtS5YbEVXs09h5d0Yuk8HAW1LAguv9ug==;31:mL6xdY/vk/VwqkGTeWf/c88X2JdjoyqNWHDRpBx3ZHvEBc1FDFT3SuEdOtVE/GSXOF++MNV7bznA5jDcwj4TGE5Va/FBBI3FR5EceAmULtBIQhYNDwoDEN1e+cQ4k/pxq7AHHWIsLcl3DVV5ocaBXicaQ7T8/p5jGe+ejploM6eV29MONXb58IexwiZ3Iar3RQevROSszczY9bX5DWwi5c2s5TU5lvp0gD2IkNzbquI=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27750FF19CB7E3D8584D91C2BC9C0@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:W9CWTe/VWpmf2t6IpPytFp0ie4z3THLncp/o2fMnPnPlbAWV13aUQr2RO1u1C3h60xf7cZAN2e548xq9f1htoBdJ2kX+EWRv8I0+FHvqFQ/ANYZoR7UiffaUhvF7DDIala3n+0z/QWvm/td4tFoGj5oOoyMrlMjxLJsvoUSKlzFOSY0AB/SlBtnqkxr2TvEGuSzACgctbiPaejb4awnXUNpHHKnUEn1KJ46nmALYKLrkvLXWQBdsfU6hSy60Te9/ZC12oFqTP/8amiYsUsBZYeNFaX1x/sN/BAeIf9c1UPKSusS1blTPusERMPP5TcQ9
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(39830400003)(39380400002)(366004)(346002)(376002)(377424004)(199004)(189003)(2906002)(478600001)(446003)(64126003)(6306002)(8656006)(5660300001)(8676002)(65826007)(230700001)(3846002)(6116002)(53936002)(31686004)(966005)(8936002)(81166006)(25786009)(81156014)(3260700006)(86362001)(26005)(53546011)(386003)(76176011)(31696002)(54906003)(74482002)(77096007)(59450400001)(16526019)(186003)(117156002)(23676004)(52146003)(68736007)(52116002)(2351001)(305945005)(2486003)(36916002)(11346002)(105586002)(97736004)(16576012)(6666003)(36756003)(229853002)(2616005)(7736002)(47776003)(6916009)(106356001)(50466002)(956004)(58126008)(6246003)(6486002)(476003)(316002)(2361001)(65806001)(486006)(4326008)(66066001)(65956001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6cnZMSTkxWnQ5VG5kTHVFK2JXdVZFaVZU?=
 =?utf-8?B?bVVjRFM0V2FEY3lOUWZUUW1ua2hNYVl1b2dHcEVCVXF2ZkhldG5FR2E5UGpr?=
 =?utf-8?B?K3d1ak9EMytmSVZCQmFQRERuTGpTLzhrejE0NmZVcDBTUUU3UWZjQ3JnU1B3?=
 =?utf-8?B?NmZUYzJyNGJLUG1lajIwSEpxNDdSb01iNkc3b3Zqdy9Ib3pUaWFxcUdWdzFn?=
 =?utf-8?B?aXcrQlJ3YnlhUGRNQjV6eXcvbzBncUJRWWpUc20vTFhmMTFRTkcrQ0RQOVNh?=
 =?utf-8?B?dVdQNng2d3JOWGQ2OElzZmttMmQ5dC8rMll5NkFNMWM1TXg2UFEzQVd2MzlB?=
 =?utf-8?B?YVppdXJnOWgvcVhBRzRnRVBBVjFxb01iVWg0OWNQMmlsblpsNXlXT0dadk90?=
 =?utf-8?B?Y1JSa3VRWTlydS9nVnlTVnA5bGEvR2x1ejVKNUhvZVVwNDZpWTFEMG5rZ24x?=
 =?utf-8?B?YnZuR1lNeXdyZzd4VlZmdXAwY3pCbkxENmdZd3dWbFN6R1d0L0Fra3FqMllY?=
 =?utf-8?B?dnBDNXE5YzNvTGFWcjNKc2FJNjFoclJmcWlDcDhWcDhCejl0NHBaY3NQZ3Er?=
 =?utf-8?B?TXI1b25JMW1kOUsyOVpWQy84RnQ1VzRXQUVrNU5qNTNObjJFNCtRSlpYTzBC?=
 =?utf-8?B?OGpSZlg3SEF2LzJGRW1YVEF5Mk1vbTJrU1AyNEtmV0VEci9JOW1ycnBPV0N5?=
 =?utf-8?B?cWgzQjV5YWdCUWhHZzlyT1VhRWxyaE41V3ZRMUNEWFpuaG9wR3l1TytBeE1N?=
 =?utf-8?B?S0JiTDZUTmhGZEtqWlViQ3p6Mk9TVjNlZ1lZRFhac3l6ejJBQ1FPejVkcy9C?=
 =?utf-8?B?VE1ZWTlJNlhjeEVNS1VYcVNRL3BDL0crenZ0eWRKY2FuNGlaUTQyRHFGQnJ0?=
 =?utf-8?B?SWZiYVhRL1p5MHA1bnkzaStkUmM0QlV0TVF0dnl3c0pQQmFCNnpTQkFWbjE0?=
 =?utf-8?B?bVBsb1RIakpDcldrMXNKUVBDSHIxdnIvRXpqUm5MZU9DR1d3dmsxcXdsbERB?=
 =?utf-8?B?Z1UyQm8ycjFocGtBdkt2WUJ3eDNqWnFiZzQwNUdBNm04SXRrbUNsR2h2UDZ4?=
 =?utf-8?B?SDFKdURPRUs0NEtRMWtzU1pPcEIvNUZzSnljb1AzMFh5ZDNveG95a3FJQW1T?=
 =?utf-8?B?bWVJMVB2RitxVEI2WlpWdmZENk9YYk9udmF4M1JzaHJRMVpUcHgyVnMzb3Q4?=
 =?utf-8?B?RzFIYWk0VUVhMWxhTDJ6VFBsZFc3aG5rUDlFNUVkS1dpS2QwZzR4S2FNNmVQ?=
 =?utf-8?B?M3RNdkVEN0kvNERQbXA2SDQvcE1UUi9sczFudFZhbGt2V09HekowWXFtdE5J?=
 =?utf-8?B?YnJDZ0xRbUNZQXhvemQ1MVZmY3FqSDJqTXcvY0d6M3V0SlhXMkNZQzh1ZHVF?=
 =?utf-8?B?NkRiQThkVVFmQ3hwZzF2a21wTWM2MU8wY3VPaUJYSGJoaWMvWEdHSnlBR3Av?=
 =?utf-8?B?VFJLb2lSTWUxeC84aFhXSUlTaExzVm1aVlVLL3BPUUFqVS9DUEVTY3Jxc2pF?=
 =?utf-8?B?VjJGNWM2ZUY3UnBBdkE3eGV0eVNuaExyVWFKdnRGQXgzcUpTODNlYUt1Z1R2?=
 =?utf-8?B?S1A5Q0l0M3lXa244WEhlcDJwQWZiNk51VEhLRFJ4Zkwrc3ZRUWZtRHQwZzIy?=
 =?utf-8?B?TWFlaExlRWhzT0hBZ3YvRys0MzR6TDlDcDF2QkhPV2xxOFdmNU1LL1MxdTk0?=
 =?utf-8?B?Zk1FZ3lqMnZIMytxWG4rMUdJZlIzOCs1K0dFVUhjRUtGM21LbnlscWttejh3?=
 =?utf-8?B?UzFWMUdxbGtkeWU4eDlrN2FZUzhHNW8rUXNXQk9yckhzT2VYb2VSY0orVStp?=
 =?utf-8?B?ZUFmOXhrM2pGTE0rbm5nTC9nYUZaa3BJZ3poODVhZ2paQnJrVHNwdHVKelBI?=
 =?utf-8?B?SEk1Z0xKL1FUMGxNSU5lMmpmSWlEUm85bituMU8vNGdiamcxdWk5YWIrVSs0?=
 =?utf-8?B?c0JoOFZSWmUvSExJaW1iLzZXcXJjUEpCMnh5ZlZSUzd2S2lSK3JDT2ZZTFdO?=
 =?utf-8?B?RWh2ZmxaR1dXNEM1SkFDeEdlSFgrd2xrYWdjaSswQ3BnQkwza2Fxcm9XY0RT?=
 =?utf-8?B?dzJ6WnZwUWthclpmTmZTT2hRcFZIZDQ5ZUhSWXdZOURjaklUbTg3R01DdE9L?=
 =?utf-8?B?MmdNcDFyOTdTWElFMm1KTmpaNENhZ29OdUhwalpIYUU2UWlONFNzeXFJR3I1?=
 =?utf-8?B?VlY5YnNhb0JxMS9mSVZjNDVCb3RPZGxYSnViY1JFQUNMWnJvYXU3S2RoK0pT?=
 =?utf-8?B?d1RPU1J0TFg1VjRhWk92OEd3NThCaTZJRk5leTBTQmNTbFRTSytZUTFRPT0=?=
X-Microsoft-Antispam-Message-Info: 2FbPjit74aEbHeXSQt711d9DGemL3cL98a1BHk8xDFDtsAVAvXZENevqGzUzBbwpZLmvBjORlztAW8nk6Il7X27nUH50ZCBXAtjMBOfMsyWzGwQcKrgAPYBC3sRfxNTyIDRyDI3tNGt7KTjuFA6kgG8yMpSR6YTZMMVgEINalqws4ZSWMtU9xGK26HkjhVy9
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:AC9uWo+KPv1dloDCbFD5O/cabRWKFOj2N2jG9tJioILYSi6sAVPzj/WUYbyf7ApQuH516UdtVfl4YjtIncDlxOSZJYkD0mv2cy0rZGIzOYHU4orlCtfyF5iFZa4lB5cD8Ev0nqCRH7jhXiLPr7Mdv6vikELJMjDruKUhsxMD6rd63z3ewd8OdE0RJDxeqLReEUDKp1aSJ7gCoTPbFndy5FRkyjfeZjVaGAHmYUTsu7/5EPfYChMdwgn0hOBNDrr5gsPOkpxva41/tCUhkybwk1D8jJ8c8cTUSn9Mmk7xMjjnqfUJ3QZfNj5MyzkyjQt2WYv9O8dy9bSD3SHObKWfGUCAs/CqSNC9fvLUG2Fqu4a1UlxKoAaH6ZqAKCIglr/HhW7UYDVb2p9qK2nFC83v9Z3vWjch7rYmhja8kkK6aOcHLBymRJqQdU+zlX4oQQ+uNJE/9G913SnIiOSA92HPDg==;5:Islr6ACqpd0JONVHKZ7d6ryyJ7svLmhqPajMxnViQUWXOEiCh4CnJjF2pqf+MYoAQAiVFV79RJ/zdL/f9XBKqPUjp5jcOZSNp30/q2WehM3L9Yp7xTzfaU2RNVJT8hKqQYi5woO3wTxUTI2E2aINO761lCxYqsDepTpjkrV16FM=;24:VzGERBUB6vpEp3zmRZxmQrquXyz44bsMRSJGILigHy2eKCARCPsfHIlQXd+rTpF2Vu0qSK8P2HcwNc53fSTXktCZClXahzyNQuyaYHMwD1I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:oPpXP6+mIy64RRcF5zNa7f92NfcfwhdAHcnC1tMBnqBDfVE27SdDu+fbfzoifh7bBVlOopl14m3Odu2MJD+RSllQOB1wzWgL4EMhEjSKVoFbjoITxJ0DYaZ3GOZKaCG0m2h4pZUkrif7U80PoeiSOSV8IIdPbwCr+kctwpsyOWcrgXn7euZ5xRy69HEMXO+dd6TlRXoZ6NyphiF2KokibIQGn/J+XQ860kKFeerHmhDtFNZTX9ScGnypEGerpMMD
X-MS-Office365-Filtering-Correlation-Id: f8954e05-3377-4ac3-009c-08d5b96b5697
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 07:21:39.9575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8954e05-3377-4ac3-009c-08d5b96b5697
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 07:48, yossim@codeaurora.org wrote:
> On 2018-04-17 17:11, Peter Rosin wrote:
>> On 2018-04-17 15:52, Yossi Mansharoff wrote:
>>> On the db410c 96boards platform we have a TC7USB40MU on the board
>>> to mux the D+/D- lines coming from the controller between a micro
>>> usb "device" port and a USB hub for "host" roles[1]. During a
>>> role switch, we need to toggle this mux to forward the D+/D-
>>> lines to either the port or the hub. Add the necessary code to do
>>> the role switch in chipidea core via the generic mux framework.
>>> Board configurations like on db410c are expected to change roles
>>> via the sysfs API described in
>>> Documentation/ABI/testing/sysfs-platform-chipidea-usb2.
>>
>> Ok, so this is v2. Please describe what is different from v1.
>> I have told you before that this information helps.
>>
>>> [1] 
>>> https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf
>>
>> This link returns 404 for me.
>>
>> Cheers,
>> Peter
> 
> 
> Hi,
> This patch was split apart from the original patch into two patches
> one for chipidea and the other for bindings.
> this patch has no other changes two the code.
> 
> I will update the link.

Just a note: I will not feed the mux_control_get_optional patch upstream
until I feel confident that this patch is going also heading upstream.

Cheers,
Peter
