Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2333068-1519114273-2-9222025176953710385
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519114272; b=OH1I1Z6BpCbunCZrySJ6hLP+/h9lGlz3XgIpE5vRwas3MW2
    97rOBmm3F74LOuXttk6gu/JHK4fluri4O7ZDcYxnW0Gl7qLH0rPsBtqHqpfZSu9h
    H+uEHPHCM/th/1NelRcxVd68PNKDKCnfNeSfWK3l7O30qtDWeFjlGANvblV4Zk/K
    fSlgsWYxiJbJDWdbBHKNTz4lcV8kS3gYIjAmtGvJv2s3ycgM+VIF2shQJ1hZ5slv
    M47RxvQt6dqGnV+KDNlb7HAvbfwViavXxkvJJ7qqT4AzTXX1NgUZTlnnttVLOlg2
    QOhaCVgkRJYJs3iXlQ5khBz1IfymfbXJonOcraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1519114272; bh=RilJrAWj
    oMUDuN7DHyYM63mPixhNW3iaxtFMWbG4q90=; b=oP2sW5lGZKrrVEe6JM5JKwd2
    OoL5umTusiklInfuBaunVKYL0Xfw5nnBSEk7OJd180IkklURAD4+a9Hl0OMY6p93
    dKZZiA7Sob1NDbHhSqDMiJAcl8hfqyb3etzu2lOh5PXw6t2Ep3pNTMDOEOFMsjvY
    QJeuRyq0zOe/lesoSvnOhmFwmzO2gYbl+V3HMgm+abrSnhspeSiNxt7IGa2edJGG
    +GTEINjZvEX09pE8gDn9dDyt9zf9OJrBrW52jbQX/OBxhyf35m9tty2UnCAoY9tV
    cPooxgqQ9gTOworneV+Xwp4H+IQ7Hb0PNmGv1wdDMniT+l/Xyzw8Ukcu8EG61A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=DLi6FOQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=DLi6FOQ2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbeBTIK4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 03:10:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57497 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeBTIKv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 03:10:51 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180220081048euoutp01c7ecd16d1b634a5aaa91e6ba1f31759e~U_lxIQFCn2778527785euoutp01q
X-AuditID: cbfec7f5-b5fff700000028a9-6a-5a8bd805bcc6
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: add bindings for USB physical
 connector
To: Rob Herring <robh@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <d5d38789-4d28-dce7-054f-f91bd82275cc@samsung.com>
Date: Tue, 20 Feb 2018 09:10:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219142847.3rnvtai6msjlyj5b@rob-hp-laptop>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUzMcRze934v9+vm8u3K7rM0dGZDU6xsv+l1aXM2WTPMbqjDb4nuqrtC
        rBemt7tUSm+n9WIla3FJosZJHaeSk6jD0ryERURlM0TXr6b/ns/zeZ59nmf7MITkDeXKRKnj
        OY1aGS2jRWTz/Z/WNZRNr1j7oNadPZU5SrFXS4wUOzDxgWIrzI8o9unkV5rNH8ojWau1Qchm
        na0Wso1v+ym2r7WMZkusJgF74WIawV42DwrZmoFeAfv31k1h0EJ5fXk9kvflnBHIz2eWUvLG
        uixaPqS3COTXqlPkOU11SD7euCSMUYj8DnDRUUc4jVdAhOhgf9c4iv3icazBaCFT0UOZDjkw
        gH3g048pUodEjARfQjAweZvihwkEH7Nfzm7GETRcLxLMWT43jNH8ohbBlSrTrGUUwURPE21X
        OeOdkJ3fIrRjF+wOv9KLZkQEfk/CqSeDMyIar4I/157PYDEOAN29DEKHGIbEK+BihoedXoR3
        QVXhMOIlTtBZ+o60YwfsB71THTOJCLwUboyWETyWwot3FQL7LcBpDJjz0hEfOwRs2QOzFZxh
        xNIk5LEbdBdkk7xBj6DLlEXwwzkE1pG+WYcvdFh6KXs6Yjq1sdWLp/2hzPiGttOAHcE26sSH
        cIT85mKCp8WQmS7h1e4w1HOd4LEUah5P0nlouWFeNcO8OoZ5dQz/71Yisg5JuQStKpLTequ5
        o55apUqboI703B+jakTTn9c9ZZm8iUy/97UjzCDZArHToE4hoZRHtImqdgQMIXMRB9foFRLx
        AWXicU4TE65JiOa07WgxQ8qk4r0rkxUSHKmM5w5zXCynmdsKGAfXVGQrsIQceu2/KnbrXWvc
        hvjc5x+7vAte9Y11uvhHtonuDD7bdqLj0UjhsN5xIuVYS1JQtf/3H+V73KiY0Erz5pDTPmav
        TXHG9aEnW6RJbU8SfY+HhrXX5y4LDqzaXiLdMvb324Voo/NG1Q5id+DaCEttcdDtveE+rRhz
        rbZkjzq3RUtkpPagct1qQqNV/gNCvczPdQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xe7osN7qjDH41MFk0dbxltdg4Yz2r
        xfUvz1kt5h85x2px5et7NotJ9yewWJw/v4HdonPiEnaLTY+vsVpc3jWHzWLG+X1MFouWtTJb
        rD1yl91i6fWLTBb/9+xgd+D3WDNvDaPH5b5eJo/ZHTNZPTat6mTzuN99nMlj85J6j74tqxg9
        Pm+SC+CI0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7UyMlXSt7NJSc3JLEst0rdL
        0Mu4duozY8E77YoN64+zNDCeUepi5OSQEDCReLPhAxuILSSwlFFiwqQkiLi4xO75b5khbGGJ
        P9e6gGq4gGpeM0rM/PSWHSQhLBAm0TNpJ5gtIqAo8bttGitIEbPACxaJT0tvsUB0vGWUWLTr
        EAtIFZuApsTfzTfB1vEK2El0HW0HWsHBwSKgKrGsXRskLCoQIdG5cj4LRImgxMmZT8BsTgEb
        iYv/DjOB2MwC6hJ/5l1ihrDlJba/nQNli0vcejKfaQKj0Cwk7bOQtMxC0jILScsCRpZVjCKp
        pcW56bnFRnrFibnFpXnpesn5uZsYgRG+7djPLTsYu94FH2IU4GBU4uEVuNsVJcSaWFZcmXuI
        UYKDWUmE12lpd5QQb0piZVVqUX58UWlOavEhRlOg3yYyS4km5wOTT15JvKGpobmFpaG5sbmx
        mYWSOO95g8ooIYH0xJLU7NTUgtQimD4mDk6pBsYJ5Q5zjnZtTFDdVqKcO1PRjnmJ8p09yxgj
        ykV/SYp/SToQrfmrI1Fj3dR7N5dnlt5xELuiYr5xz4aXRx6y5P6q+X3fhM3+3uwv/NXP7NuX
        hLdNO1iyjVsrhclT1EqO8fRUbxU99cS3YY3SkkdZ1p5/v+/Tu/TZzSv3t1482d2gdlBguv7K
        J/1KLMUZiYZazEXFiQBkKu05BgMAAA==
X-CMS-MailID: 20180220081044eucas1p235a117bb68632759d01840e267a7005a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180220081044eucas1p235a117bb68632759d01840e267a7005a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71
X-RootMTR: 20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71
References: <20180215103920.32017-1-a.hajda@samsung.com>
        <CGME20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71@eucas1p1.samsung.com>
        <20180215103920.32017-2-a.hajda@samsung.com>
        <20180219142847.3rnvtai6msjlyj5b@rob-hp-laptop>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19.02.2018 15:28, Rob Herring wrote:
> On Thu, Feb 15, 2018 at 11:39:15AM +0100, Andrzej Hajda wrote:
>> These bindings allow to describe most known standard USB connectors
>> and it should be possible to extend it if necessary.
>> USB connectors, beside USB can be used to route other protocols,
>> for example UART, Audio, MHL. In such case every device passing data
>> through the connector should have appropriate graph bindings.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v3:
>> - removed MHL port (samsung connector will have separate bindings),
>> - added 2nd example for USB-C,
>> - improved formatting
>> v2:
>> - moved connector type(A,B,C) to compatible string (Rob),
>> - renamed size property to type (Rob),
>> - changed type description to be less confusing (Laurent),
>> - removed vendor specific compatibles (implied by graph port number),
>> - added requirement of connector being a child of IC (Rob),
>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>   by USB Controller in runtime, downside is that device is not able to
>>   report its real capabilities, maybe better would be to make it optional(?)),
>> - assigned port numbers to data buses (Rob).
>>
>> Regards
>> Andrzej
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>
>> dt-bindings: add bindings for USB physical connector v3
>> ---
>>  .../bindings/connector/usb-connector.txt           | 74 ++++++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> new file mode 100644
>> index 000000000000..1efda92639da
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> @@ -0,0 +1,74 @@
>> +USB Connector
>> +=============
>> +
>> +USB connector node represents physical USB connector. It should be
>> +a child of USB interface controller.
>> +
>> +Required properties:
>> +- compatible: describes type of the connector, must be one of:
>> +    "usb-a-connector",
>> +    "usb-b-connector",
>> +    "usb-c-connector".
>> +
>> +Optional properties:
>> +- label: symbolic name for the connector,
>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>> +  non-standard (large) connector sizes: "mini", "micro".
> The smaller connectors are standard too. Perhaps "non-fullsize connector 
> sizes".

The word "standard" is used in specs, but your description looks better,
maybe even shorter version would work: "non-fullsize connectors:".

>
> We're missing a micro-AB connector, but I think those are actually 
> pretty rare. Most phones are micro-B connectors, but do both host and 
> device.
>
>> +
>> +Required nodes:
>> +- any data bus to the connector should be modeled using the OF graph bindings
>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>> +  the connector. Since single connector can have multpile data buses every bus
>> +  has assigned OF graph port number as follows:
>> +    0: High Speed (HS), present in all connectors,
>> +    1: Super Speed (SS), present in SS capable connectors,
> This should also say endpoint 0 is USB-SS, endpoint 1 (and higher?) is 
> Alternate Mode. And show in the example.

What if there is SS mux before, which muxes USB-SS and DP lines. In my
case the mux is located in USB-PHY (it is 2nd example below).
In such case there is only one graph connection to SS port and this
connection will handle both USB-SS and AltMode traffic.
Anyway from USB-C connector's point of view, there is no distinction
which lines are USB-SS, which are AltMode. In fact platform decides in
real time about muxing of SS and AltMode signals, as it depends on
cable/plug orientations. Maybe instead of mapping endpoint numbers to
SS/AltMode, we should map them to SS1/SS2 lines if necessary(???).

To be sure of your intentions. Do you want to model simple SS muxes as a
part of USB-C connector?

>> +    2: Sideband use (SBU), present in USB-C.
>> +
>> +Examples
>> +--------
>> +
>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>> +
>> +muic-max77843@66 {
>> +	...
>> +	usb_con: connector {
>> +		compatible = "usb-b-connector";
>> +		label = "micro-USB";
>> +		type = "micro";
>> +	};
>> +};
>> +
>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort:
> Having SBU to DP but no DP video path connection is wrong.

But it is real hardware :)
As I said earlier, DP video lines are connected to mux in USB3-PHY.
I can add this explanation to the description to make it clear.

Regards
Andrzej

>
>> +
>> +ccic: s2mm005@33 {
>> +	...
>> +	usb_con: connector {
>> +		compatible = "usb-c-connector";
>> +		label = "USB-C";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@0 {
>> +				reg = <0>;
>> +				usb_con_hs: endpoint {
>> +					remote-endpoint = <&max77865_usbc_hs>;
>> +				};
>> +			};
>> +			port@1 {
>> +				reg = <1>;
>> +				usb_con_ss: endpoint {
>> +					remote-endpoint = <&usbdrd_phy_ss>;
>> +				};
>> +			};
>> +			port@2 {
>> +				reg = <2>;
>> +				usb_con_sbu: endpoint {
>> +					remote-endpoint = <&dp_aux>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> -- 
>> 2.16.1
>>
>
>

