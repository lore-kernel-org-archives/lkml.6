Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2045840-1517821620-2-3784588621794444447
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
    t=1517821620; b=ogguMn01CH/0Hpp/k3CrjTq0rwx6IiY8t1fj2H2OhNFLbVi
    g00Z/W2ZWqA+DLFgxYFHR4OfeAI+4Td0b4HyEZt2uKb9N5f4CsZN/6GlrYBaSqDO
    wIsx225dGiT/4ZaGKPhfdBXJ1r+9FMBEx/hQlBdTTnkrCaaOB1qamrBVG6zQUo2a
    gs3jJ1gq3yeNSm1OGYSlXhz6l/CPw40m/LpjTWJTstAodQBy7hHyXzqI/f/dsRl1
    ONub71MfijxpLZNAmlhvuFBAcm1scOGORspgsRJ32hBa5eu7EU0P3f+AzXL9SHDT
    4kcL+98UCq4LHHEg6Q2d4kElDJJH6hFAHvh1TcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type:subject:to:cc
    :from:message-id:date:in-reply-to:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1517821620; bh=ja6A/17G
    GoMgun9cZH8pE/LVXOrwPXjtgCYHmMb678c=; b=J4Tr6QCbF0lol0qbI4mrADpQ
    gey/6qBf87NtS9wj1oo5cCBr7s3TS2ymTFws7SkLF6Y7lG6CFcrHup4NNxCG6f0h
    q3hNTKktS5ORWRkPqvCJpAvn6j2hNQPJjtzrGGaCWBe0Q15Kia1E+OgzBOiwyvH4
    nYylPBf5tBcG6WFQrcGF8UowXxZLxhvqLUhBdx36BqBTBPLURaDX9eGOVtuG1m6G
    dkRCaEwziSDpuUOyPXqUC7oZKBC0bIN7ktJCz7XRprcOpdHUAsqZ80BsdpK9VcLz
    MMRgu+ltQj/NSFAXj2jajP9UlbEY8Nk6u9cBDVNGF/TE6xDD7RtjpMEipW+tPg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=N7rnF4jJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=N7rnF4jJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeBEJGp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 04:06:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48070 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBEJGl (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Feb 2018 04:06:41 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180205090638euoutp01db7cfaae1865e20066859e96eb66547a~QYrPQ5RJo1451314513euoutp01d
X-AuditID: cbfec7f4-f790c6d0000075d3-38-5a781e9da64d
MIME-version: 1.0
Content-type: text/plain; charset="utf-8"
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: add bindings for USB physical
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
Message-id: <a9745020-602b-8274-e2d6-63295f5b3caa@samsung.com>
Date: Mon, 05 Feb 2018 10:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGeXeuDmenOfOPRdIqoii74IeXNLGoOEUf+hDWhLKVh2U6lU1N
        A1NmjqldvOVl3ipTcJjWjLCsyGWbpWVeSk3UD5ZGIFpNSKPLtmOwb7/3PM/zv3FYQv6eCmLj
        ElMEXaI6QUlLyYf2xb5tNWvTo3c8vbwVG0yzFL5f0UrhYecMheu63lJ4aGGOxsWThSTu67vH
        4LyiOwy2Tn2g8ODjahpX9D2T4NuNuQS+2zXO4Ibhfgn++6SdiVzBN9c2I37w2lUJX2WqpHir
        JY/mJwscEr7tThZ/7YEF8T+sa4+y0dLwWCEhLk3QbY84LT031HaLSm7Ylm6yN1HZqGxDPvJh
        gQuF5t7XtMir4N1Eq4flXAMC20xSPpK6+AeC6ukCyf9AVX0DLQqNCK68qfUIMm4l/CyZIN1M
        cJvhi7OYFE3TCMZK5hm34M9FweJYGXKzglsHv4xllNtEcNMkGAbGPb1pV/p32ygtVo2A/JeL
        nqoktxEckx2EmwO4E3DrxmdXIZb14cJhwHBcbBwMnUMzy0MEQk7uqGcI4BoZsDlNSFxhPyx1
        DBAi+8NXxwNG5DWQZ+qUiIECBN+vdzPioxTBn/mK5UQYvHD0U2ILPyh+WE64pwBOBiajXLTw
        UNSytGzfC8b73wjxFLMInpUbUSEKNnudzOx1MrPXFmavLW4i0oIUQqpeqxH0oSF6tVafmqgJ
        OZuktSLXz9bzx+FsR/X23TbEsUjpK8MxF6LllDpNn6G1IWAJpUK2b9j1SRarzrgo6JJidKkJ
        gt6GVrOkMlC2J9qoknMadYoQLwjJgu6/KmF9grLR1QXW7zbu+bv+VFqjqsYQQB5fI63L/JTN
        ZBIfDwVOGYqs88+voCO+Hyxh+Snl482hUSruTJ6Q9qQypzcw7L1v1yX/w36Re1pGTm7KiaIj
        44LPh8+N2E+nv7gcXNe/daz0VdNBi6Lz0S6HKsu6t3vhWFWPZvZAZn2XIMWVHYO58UpSf069
        cwuh06v/AczTtxJoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xq7pz5SqiDPpvMVo0dbxltdg4Yz2r
        xfUvz1kt5h85x2px5et7NotJ9yewWJw/v4HdonPiEnaLTY+vsVpc3jWHzWLG+X1MFouWtTJb
        rD1yl91i6fWLTBb/9+xgd+D3WDNvDaPH5b5eJo/ZHTNZPTat6mTzuN99nMlj85J6j74tqxg9
        Pm+SC+CI4rJJSc3JLEst0rdL4Mq4snkha8FS3YqOYytZGxinqXQxcnJICJhIzF68lA3CFpO4
        cG89kM3FISSwhFFix44Z7CAJXgFBiR+T77F0MXJwMAuoS0yZkgtR84xRYtqDR4wgNcICYRI/
        b08Ds0UEFCV+t01jBSliFnjGInHu3R5GiI63QFM/vAGrYhPQlPi7+SYbxAY7ia6jP1lAbBYB
        VYnj93czg9iiAhESnSvng23mFLCRuNQUDhJmFpCXOHjlOQuELS7R3HqTZQKj4Cwkt85CuHUW
        ko5ZSDoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIy/bcd+bt7BeGlj8CFGAQ5GJR5e
        i/jyKCHWxLLiytxDjBIczEoivE7XgUK8KYmVValF+fFFpTmpxYcYpTlYlMR5e/esjhQSSE8s
        Sc1OTS1ILYLJMnFwSjUwalbqb56uss3/Vumnl5umH3he3BfHusz00IGr75cIqe6eeEouVCFA
        zUfPsrRya9pF4SUKCrdelL1t3/bH0938CXtl2CemBY/uM6i2yHgm+ywwmaBouOXbNn2Ry88+
        lrFJtG1qsBEV/rbsvd8k0Qtv+BgP5x+yu23wb9MkrjjeUsfjlU48/OX6SizFGYmGWsxFxYkA
        40f9C7sCAAA=
X-CMS-MailID: 20180205090637eucas1p1849fba83c2fcf7d74089461aa4b02612
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1
X-RootMTR: 20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1
References: <20180131134435.12216-1-a.hajda@samsung.com>
        <CGME20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1@eucas1p1.samsung.com>
        <20180131134435.12216-2-a.hajda@samsung.com>
        <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05.02.2018 07:08, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 02:44:31PM +0100, Andrzej Hajda wrote:
>> These bindings allow to describe most known standard USB connectors
>> and it should be possible to extend it if necessary.
>> USB connectors, beside USB can be used to route other protocols,
>> for example UART, Audio, MHL. In such case every device passing data
>> through the connector should have appropriate graph bindings.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v2:
>> - moved connector type(A,B,C) to compatible string (Rob),
>> - renamed size property to type (Rob),
>> - changed type description to be less confusing (Laurent),
>> - removed vendor specific compatibles (implied by graph port number),
> How so? More below...
>
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
>> ---
>>  .../bindings/connector/usb-connector.txt           | 48 ++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> new file mode 100644
>> index 000000000000..02020f5d760a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> @@ -0,0 +1,48 @@
>> +USB Connector
>> +=============
>> +
>> +USB connector node represents physical USB connector. It should be
>> +a child of USB interface controller.
>> +
>> +Required properties:
>> +- compatible: describes type of the connector, must be one of:
>> +    "usb-a-connector", "usb-b-connector", "usb-c-connector",
> Nit: one per line.
>
>> +
>> +Optional properties:
>> +- label: symbolic name for the connector
>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>> +  non-standard (large) connector sizes: "mini", "micro"
>> +
>> +Required nodes:
>> +- any data bus to the connector should be modeled using the OF graph bindings
>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>> +  the connector. Since single connector can have multpile data buses every bus
>> +  has assigned OF graph port number as follows:
>> +    0: High Speed (HS), present in all connectors,
>> +    1: Super Speed (SS), present in SS capable connectors,
>> +    2: Sideband use (SBU), present in USB-C,
>> +    3: Mobile High-Definition Link (MHL), present in 11-pin Samsung micro-USB
> This is un-muxed unlike Type-C where the signals are muxed with USB SS. 
> That makes me think the Samsung connector should have its own compatible 
> string.

Do you mean, sth like:
    connector {
            compatible = "samsung,usb-connector-11pin";
            label = "micro-USB";
            ports {
                    #address-cells = <1>;
                    #size-cells = <0>;

                    port@3 {
                            reg = <3>;
                            musb_con_mhl_in: endpoint {
                                    remote-endpoint = <&mhl_out>;
                            };
                    };
    };

Or should I add "usb-b-connector" extra compatible and "type" property?
I slightly prefer my approach(less different bindings), but I am also OK
with the above.

>
> Can we go ahead and define the video modes of Type-C? Normally, if 2 
> data streams are mutually exclusive, then they are a single port with 2 
> endpoints. So we'd either have 2 endpoints on port 1 or we stick with 
> port 3 is always video. We can still know what is mutually exclusive 
> based on the compatible. 

I am sorry, I do not understand what you mean. Port 3 is present only in
11-pin Samsung micro-USB, USB Type-C has only ports 0, 1, 2.
Here is list of possible ports depending on connector type:
- USB 2.0: HS
- 11-pin Samsung micro-USB: HS,MHL
- USB 3.x type A,B: HS,SS
- USB-C: HS,SS,SBU

All ports have separate lines, so they can work simultaneously.

And regarding MHL on standard micro-USB connector. MHL and MUIC will
share HS port, but there will be mux somewhere before connector:
- in MUIC, in this case MUIC will be the parent of the connector, and
there will be graph from MHL to MUIC to describe MHL link,
- in MHL, in this case MHL will be the parent of the connector, and
graph between MUIC and MHL to describe HS link,
- dedicated mux to MUIC and MHL, controlled by gpio pin, it could be
handled by MUIC's external-mux gpio property for example, or (probably)
less hacky by separate node for mux,
or as additional property in the connector (who should be the parent of
the connector then? Probably MUIC?).

Regards
Andrzej





>
>> +
>> +Example
>> +-------
>> +
>> +muic_max77843@66 {
>> +	...
>> +	musb_con: connector {
>> +		compatible = "usb-b-connector";
>> +		label = "micro-USB";
>> +		type = "micro";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port@3 {
>> +				reg = <3>;
>> +				musb_con_mhl_in: endpoint {
>> +					remote-endpoint = <&mhl_out>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> -- 
>> 2.15.1
>>
>
>

