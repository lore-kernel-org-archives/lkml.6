Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1194855-1524489802-2-14179734591342829759
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524489801; b=SaoZ1ItKMEZ1tpdoZdNJPo/Q0aq7AODQyb3S1gY/qNNsDjfeXc
    OdAuVwCrWgiZ8LZEiWqzcru8rNB3rQZvScQVVcX5FyvnNgyYYiEQKIxCh9LC9yCY
    QRmRXq5ujKCikZcwb4RTvBpa4y1TxGT8P4LrUVP/W9rzczxuSLmm9ATQtAjXxPe8
    4KWX40DuzWp6ZPsjTI2cXbEcVOYkKfKviZnvlQoWOnNYtqoDajIxDJhrnTvEnha+
    UXjIfothggHKmy6MVyDKODWpXx806uGCzsUVawseLpI/2qacoJuPRF5+4zOy9foV
    qsPxnOpxFjU/OfqX6Xb5JgwbqwuGlojhH/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524489801;
    bh=o3QamU5b7JpKpCotzFmxK8m3si3EoYdgtFUBCf2ONJE=; b=PH6GXfsIhTuf
    EM8YwZo0oU+yIhe2fZ13njOLMHimxAsm2zFKFG5ZYM9SnHUeTxkDDhgR17WjT4VT
    Kcyw0rDm/i/PurNJ4hjWinJeFhXXssD+G+qISSwl35c3IKrxSWYC4oIKp7YYCVrt
    O2rVYlPF94+W7INVlAkoxuA2znzpzOL/Dw8irFbeSThrzMDT5WanplTH6xvfxD+r
    n2TXb+reA5F0EO5PgpiRQrYWSsQtzMV4KJpkDJTMwDbCtzZd4F5tm2aJmLM87n0q
    idGsoYtIegG8wp5+BqLPriQ/z8WwMHqKwYOWUI8G8C9La9s3jeSOO8g6KDNwGxdw
    yaQmdRGcJg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=yBBp7xo5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b=yBBp7xo5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-xilinx-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGPKA02tVMEgQImZhWFGHtOmioj6JY2O6ZFSRYxcCK4Xx+/MYFdyNcamYcyvrNhamSZoSSVj0uHQoYjaaF7N3tJgcMcRV8PqY7EP1NfB4Q1gIV9Hgcqn
    0T6BcQta8ecPZ4ur/JmExQ00a9mfFdjmjVsGw1eoUAXLbnYL6ShBCQ6rI2T7yUeOOOMwwxRhlCX42SOXw2VplHiCgup9PIKVV5Yh4Zcrj08oXdl6cFraMjUj
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Am4ss40yAAAA:8 a=gPJu0pBYAAAA:8 a=VwQbUJbxAAAA:8 a=hpEWIbGF9oHwdl_8F8gA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=lf-hbUz_c89dky27wAWH:22
    a=AlIIF0cMT2hfDT4axODj:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755207AbeDWNXS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 09:23:18 -0400
Received: from mail-bl2nam02on0053.outbound.protection.outlook.com ([104.47.38.53]:20736
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755273AbeDWNXP (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 09:23:15 -0400
Subject: Re: [RFC. PATCH] earlycon: Remove hardcoded port->uartclk
 initialization in of_setup_earlycon
To: Matt Redfearn <matt.redfearn@mips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <devicetree@vger.kernel.org>, Rob Herring <robherring2@gmail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>
References: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
 <6626f66e-e1a6-9e54-0011-95ab4949bd3b@mips.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <18997e5d-dcbf-3a99-e1db-994ba97b1e24@xilinx.com>
Date: Mon, 23 Apr 2018 15:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6626f66e-e1a6-9e54-0011-95ab4949bd3b@mips.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(376002)(396003)(346002)(39860400002)(2980300002)(438002)(51444003)(189003)(199004)(9170700003)(356003)(65826007)(478600001)(39060400002)(5660300001)(186003)(229853002)(126002)(2616005)(44832011)(476003)(305945005)(2906002)(63266004)(6346003)(31686004)(9786002)(8676002)(446003)(11346002)(426003)(230700001)(4326008)(81166006)(8936002)(53546011)(6666003)(86362001)(6246003)(316002)(58126008)(110136005)(31696002)(23676004)(336012)(54906003)(36386004)(2486003)(2201001)(106002)(26005)(76176011)(64126003)(36756003)(486006)(106466001)(47776003)(65956001)(65806001)(50466002)(77096007)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB1671;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT018;1:r0nim6YYcj0hi5T6sxYVxKwjmJbVIqPG4yEus6VZPutsap0p3K/9q2GuHqUUoxMAeM7nxqYV+hbI9EMK+3ZjEZ2MZagKSrAqzTbR0xpmMABfGa/uIA+XTJFCHZBaZ1G/
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY2PR02MB1671;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;3:sQ4mI/f794hLavDZXiHfqbtyGvlTkCTG0XgkioxQE6vIoQ8WiLeuAKtCcXkY0GNq8KihKDbnXRg2z9rbl+S34o7UgZdkPP98KzG0EoMGw53b83M5Koj63qaNUZ1Hej8aTW3hsS4toL5PTTnWIU4/Qq3ghIoSnUezynXHsqfdJMc9pitdrDRiPM2cz5dBJXV7OCy55aJ0ozwvw3SZ6F+IRBgAZGrP3PkipcZUJKPwfnfZoDRdtEP93MoUMllF6FPOKMzotW6sSq83rWKmwKVRTPW+ZpRKF4kxh5rnBW/x/fV6ariQwWa9SjI0W+Zb3+sdZUkMJEKQTyGih1911Hzw4YGrXqFEb4SNN7ecxb66DHM=;25:PwwsaD7sL7au5iXrzuW6AlaQ58nb9B/ut2kkE5D3Y6RvOODZgk50wSPiQx4gFXM4Y6LBVd3+z5YpsCGMRMYa4MVu4e1XtDWira4tGw4PEDWZX6MVXovHfUcpJ7OYx+6QIt4C2UhFpIbG1WxREjOxuemSv68IE9Vt5H1coB7rxLvZvoQ0FQky0+uhv1tcRZzYnzxZ/XV6XxhPWVM7cwK7lvs8TJX5/+XlHZZFKhjFt9M0d9jWhHKlnH8vf0jBNQm5dtVF5P6k7qKzsVqZX0Sqaj3Pr86xxlAMGTg1+2THnW6OVLI6r0RkArZlsrrmSIkv52X+V4GXNzxtzoxDx+dAwg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB1671:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;31:yfYmJfrsaa6fyGrdYqfzDSxIUnLiQstguX2B5GYPnEypoV3iBCX2mTL3VX7BDt+e79TRX4vPSbCvtm/pi5uWKNvbhj+RdDkWoijVl1tT2sm5VR7Tr4J72AALpZMCA+Q5dRJtFEcZMGzZ8iLFZc/82xFJRbz5lMJk12CkCRN03kJ+oerpmllockA5osoSmUloZZfu/BNn+I4r0poSBBHCkDKO9q3ifPSCG+4VyWwYXA4=;20:ilv2PjK3xZM3RbYSeXWOSlqz/EHfh59lPaBVBO41TsFve//rf8gzRmFnQsTQMKH2yMCVbZRNj+syPbaUtrcWLq8VG9I2UJwhxE37X0homKFGYZIPNa1aGIJCqPOxGjs6QUXAxgVssyqfOislP/2a9uMu38f47DxfpwpfzlGsj9fzx2NzifxkqbLn2hmFnbo3enK4y2hAyWRTGRp9Lxnf8QkZeP/jzbWkZpmg0e5Fe/1raVC1b0+4zg39BImsgDkhpz63rlDquljp7KpvT/5Kd5YTISASaiFFqvFyg7iEXVcgDzHrvqdQYD1shtjgMXMtXlADVGtF4XTfQp/DGyzxZjhBQZJs3Jnz1qo2vhDIS8ov3AFnmbq3z9oA/mz2ad8btSKa0oQ5yp4unpH+cS+oK4lktjrchRWK8+9Fgw0bGQE/TdapkVsUL0/zwGnZdKloyKf6o9zA3uiVnsmZnqTa4SxL2EbnPdVXmvMKXZJTzs4J2t0FaOtlkn2UdSsiEN+2
X-Microsoft-Antispam-PRVS: <BY2PR02MB1671B19BC9A37D5DFA835BC5E2890@BY2PR02MB1671.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231232)(944501410)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BY2PR02MB1671;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB1671;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;4:SckOCeEyj6gZv26j44hG02TwYT1mvP0NmYUfzEQSoYYX/yoEKIXf50DWlNOcCITtz/sq68thh9bohHMVDTqRL3bH0QcLSYUfXCzTwuQO2bCeuWvPI1rBB4MaG0/M6F0KeiekbNx0YlYZFcm66B/hQDjEhHm0gEPRr2tLbjIjpM3aYRPQmhT+B4xU8z/79Lcby8B9Ku3vWcLG/JscoNaItyBKGf3RHeywKJxYRLkNtmR1FZxqMmJhZBRDYLgWPKSZ6sgnR3PVwJDR1kWkUujSMiQrgEDvIq4VOJb2BkW5DpjC+Oc20t/WDxu5Cpq62ohy
X-Forefront-PRVS: 06515DA04B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxNjcxOzIzOkZLeVFWcHZYNk8zWkxsbHVHQ0c4VzVnNFB1?=
 =?utf-8?B?SWdMakg4Q2Rod3VQTXRERnlKSEVMNFQ4NkZ2cWtRWDEzNHl1ZGZuTFk0UnlT?=
 =?utf-8?B?YzhjenNDY3BvYit5Tk5jdmIrUlVGNkFIc2JIUmJTeVBXL1p0SnBoRE0wOEpr?=
 =?utf-8?B?am5KbnFBWFpHUGhpbHNFbXd0Tndhczd6UWZ2Wk0vUktYRnpVZUtJcEw4SlJZ?=
 =?utf-8?B?bXRyOEpMencrVUE0YXozVjAzbTVQNUl2S3lFelRuWDlkSzBCWW9WNmlJdFNi?=
 =?utf-8?B?MG9CUmoxckIrNFRjc1haek9RcjI5M1ZIT1VocitPM1B4TllYcTVabFBsM3Jr?=
 =?utf-8?B?Z1lWQUkvR2JMT1lsZW04Tk5YKy8vak9lcVRjeHRkVzQ0ZDVIRU9BR0VwbVdJ?=
 =?utf-8?B?S3UrNmNQcE8zRVFaaXRDTlg2SHIzdnppMmdoMWZTRlM4TzhGT0FLTlpqeVk4?=
 =?utf-8?B?L1Y4N2RSWVJONXozTnljUDNQUlVSQjJMTElLczREZno2Y3lPaitSQWFZdXh6?=
 =?utf-8?B?M25iSk5pcHlaR3E0b3ozZlhRZjhhbmxDSEJvZVREQnNWYlRIQWJsSjVmaTJi?=
 =?utf-8?B?eGZaWFV3VHB6TG05VjdnWkgvbjNKOEQrakFxc0U0elhjOU9RV3dsQVRKem52?=
 =?utf-8?B?TVowTnFKajQxTkJraEpvTE4wS21pL0EvTUE3aDBCc0tQcXpFMk1Yc1JoTGJi?=
 =?utf-8?B?K0pVS292QU5uUHdlaXRTSjh1aXhCMTRJamwraEJLa2w5L2NrNkMyQ2tuMGEw?=
 =?utf-8?B?YmJ1YkRQQlZOZHV2KzJRRzZndHJweEszS0J1RXBNakVCMENTa25zM29VdElW?=
 =?utf-8?B?eUJWTXZoN1pmbGVFbFl0djQzU3Z2bk9leFZKWHl6anJESzN4NE5iZUEzWHpE?=
 =?utf-8?B?RlhyT3dZRXRSTHBRUW1UMUVyY1d2bVEweERpQ1lKVmxxMGRubDJDaWR5ajhh?=
 =?utf-8?B?TDdydXJzdlhDcCtqdldYb0h3YnV1LzZSVytwSHM0L2pmbDFzRitZQndwbi92?=
 =?utf-8?B?VmpDdjNCWXB0aVRaNkxVUXdYTDZTNTAvemVKNGppWWNzeWRZQmxoRE5NTzNZ?=
 =?utf-8?B?cXdnUy9tYVg3VC91UDI2VVRhVytEd1J1cTY2MXpqL0tWRmxDVk5DU0Jkc0lH?=
 =?utf-8?B?YVlIcHhjNXI0cXJRYXNlMXJJaE50ZXVUSi90Qk9EVU9taC9DNHdQODBNWEFS?=
 =?utf-8?B?VkEvN3d5OVA4UmlpKzdPZ0tVdS9oU3NJc2V3K0tUbXcybThkZlZMTWQ2dVVV?=
 =?utf-8?B?TDd1OEU4ZTl0SGZHZWhpNkw0VnAycnZFODNMVjNXamFpdHdGS3g4QU04OGtZ?=
 =?utf-8?B?eThGTnlVVHZ6OE5mSzAxUGlZMHhzQWtIRHJLNzMySWZsRS80RG04UEE0QW5v?=
 =?utf-8?B?Uk1IUHFhVldaZndCV1RxampaY004bHdicVJQQ0R1d0pWM25VSTBFTEp5NHV4?=
 =?utf-8?B?SU9zV0QvZ0l1MlBGR1NzcXJOTTZXSDFvaGI5ZlRBWWt3aVMzbFkzVWxwMFZ1?=
 =?utf-8?B?TDZpS2xLNXVHUjdtZjV4c3RuTDFiR2ZVYTBTZ3RqTjZvQUxWUGFvbnR2N0cw?=
 =?utf-8?B?Ky83aGJoMmF3ZUt0bEp5cWZmUHRCZEY4WUpCVXhqK3I3Zi8vTlBXczVxRjJu?=
 =?utf-8?B?QThHU0Jnem1POXFzbFQzQVlvU3lId2NRNlFiNDcyZVp0R2dQbkNuenFaVGI4?=
 =?utf-8?B?WC9iQS9GVnhTeHIvb0JVU0w5WmN1VVhWbEhabzRISGd3Q0pwSXp2L0EvcHVW?=
 =?utf-8?B?bEVhZG1BTXJnWHpxK2dac0JnR0dvTnlaeVNiYWNSSlBYUzMzdzVYVjRYZS9a?=
 =?utf-8?B?eUNndDFEY0YxRVIwNm90M3dHK2tkMUZOeHdjQUJRSXZoQTE4ODdFWjFtYTNl?=
 =?utf-8?Q?szZo4uueNTp42KPpr86KLa5JtJEJ354C?=
X-Microsoft-Antispam-Message-Info: Xp5vlFvi7VqB5cDmb8U33atiMGjvXOncmv+W6lKFlpBmP/jZpvkQ4YGPpSn1Tl4OPB8mPL3/R8XWKXT8fusE055u1MRe6rfo6zfzdfOvrG7b5C5ssmDaHUPZxA1pa8/elzYUoAp5lTzl1UTVc0PHOFU5y6+xZSHJ40KljVgiUAey+Oe7ZT185NoKLSlpU9mu
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;6:rqapQtLS4W5MTiea31N0A+3jMxYSd7BUNReHrUa3DWKh2kQrL46MPdUN3+mYv2kRCEanWiiJ3HCp9+WD1Mafl2ToGDXv+SoJGN7iLQ3/K8Go3j+2Zxtco6/oSoIcukF5N9yur08r8Y4e5R6S2W7gBY2mrGjAAkyztVBEQbItNQ5pAP/N2roW2GDFYDhYakLnODrUtZNI6KcXm2+vHaLfs1IcJvq6T3PDreFyzBkWU5GFUcpm9ipWCGTAJr1nsLyEAXUftQgyOMj4INhbDaEM/CjMSE4KdtjnOhiPchqFJdzRcMd05Iq00w9Uvu9Pg7E9RaJ/kww4zhe/fx2UjnZ+hXMJket6SkRNEz1eCyV/zN+IjiphOSdq79iXkC7BrUBPCQKksAbyiXxjmbfylNdfuHFv5SBgwN0x4Oe/P1DDeZgZUoZTxWKE4irSbuDyWSbgqR9Ck6p0nuLLEeSyuagjdg==;5:KlTHHgVp6g79eWF550D8O3F66K3KzwDreQbTtj9xIyE3hvbISGtHINEm+seyhNuP+QKB7RmHCIL4rM4owWk6M1YVlV59ses+D/2J1DMSwtK1K3o8GjQnD3U6ZDQ5jQ0EX17RuhoGoEngHp9QQIDXa5t6KL+e9gyKkr75RAYZWbQ=;24:iNIjHSO/A0dyukhKOTKniquIKi2qNJzakpnL1e9GsO7KyV6t5WM30sNv96PS6ZY/v4INjDkKKKbu41AVGqXDiaC47/0UQ4g6jVPpVKN12oU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB1671;7:bccnIcwz5Jsa0RHQuHL6agVYrGd5SM1UK4TJEvavF75VwkYWokqO6H3tnmzb3lD99cfDU3qnb7xYB5fPv4IcVto/4cIMCYXjMba3QtTqiT1iMBTGa2P/171cSzfMO3Tyd2KhXOiHo2d/MCZIIlodwGXz4xnYJdn9uFYcqSUsB1VuBJHVEJCUKun9KMRcUE52b016ZLzwHwiusaqyPlykt2dGYZ+ZbBTcpxsNYk3JJ5dY7HNWTMmBA6XRh1D9GL84
X-MS-Office365-Filtering-Correlation-Id: 8b411e6d-bb6c-4292-1ace-08d5a91d5c6a
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2018 13:23:10.9271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b411e6d-bb6c-4292-1ace-08d5a91d5c6a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB1671
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 23.4.2018 15:16, Matt Redfearn wrote:
> 
> 
> On 23/04/18 10:27, Michal Simek wrote:
>> There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
>> systems.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> It looks like from history that portclk = BASE_BAUD * 16 was setup to
>> get on calculation on x86 (divisor = 1) but it shouldn't be needed on
>> DT based
>> system. That's why I think that there is no DT based system which really
>> requires this line.
> 
> Hi Michal,
> 
> This is fine for the MIPS generic platform (tested on Boston board)
> which was broken by some earlycon changes a few versions ago. Also
> tested on a MIPS pistachio board. As long as the bootloader has
> configured the uart divisor, earlycon should work as long as my patch
> "serial: 8250_early: Only set divisor if valid clk & baud" is applied to
> avoid a bad divisor getting calculated.

I have sent one patch to fix your patch because you don't need to check
device->baud twice.
[PATCH] serial: 8250_early: Setup divider when uartclk is passed
 > Tested-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks,
Michal

