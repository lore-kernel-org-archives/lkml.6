Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2276771-1518082100-2-5396219524368144914
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
    t=1518082099; b=IVegtcQFWprODGuSt+z8acACOZfisu46eFYE1uQpDHucnJx
    qweeebrRZp+ARY5n+r9p35mAwnpiulZXtMI3IkN/kL7EkxuzGlodQVX4qyWvf0BE
    LKlq3UmfkXfPNTXgqDNTHyDUxsENrsQ1tV++sE3X5VecksMfIuWy3ATgzkBrZxzk
    pFjsPli5obdKWNQD3yj1tie46dOSt+5yakiCcxwlQK0kR/lrlIVKsLvNlHAq1lOr
    cBe7p3Fe+NbayJXopXhhgo3ceK3WoDY8PaAqH95V6KH8nvzebb4HdHlOJXte1Tcp
    WQVMG6G++4lw/MUgag4NpfsfMFfSdYAYwns51YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-type:subject:to:cc
    :from:message-id:date:in-reply-to:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1518082099; bh=e0CCMaH3
    VZmC6ZXRMbRaj38yJ6qwq/Y5UbwV1Ia4r74=; b=JjqxP6kr4QGIfgwFKQfVwXJk
    hDyJ1e7oXctAvgJzuYRLbDYYZxzySIq8JkS3J5TU5DtPjspUK27GnvZPA1OmkDpd
    h5daEkPnmegtMI7qCuWzZryi6NEoyCZpyCBt6Xyng3VAUrE5pp7kQHHgnCd1SjN3
    HcYw3kWRrjqQBs01m5PAGwh6oTUIucmuGbqTFS46V+T9N4Jje3G/dyb17cEseZi3
    nu7DJkpsrec6X1Kl+iXkawYmyOW51cwFSrR9xYOTM5N6WSSGHM+14L/MSnZ9Yga1
    Giq8Ny3kfqCUBIuVMG/mhG8RBHj53wGNWisIt4NBWEAx5o4nouP9VIYG6BON8g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=YBxxI61K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=YBxxI61K x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeBHJ2H (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 04:28:07 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52178 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeBHJ2A (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Feb 2018 04:28:00 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180208092758euoutp0163374913aa21a31f86e9861681714d42~RT5tqo4Xx2840728407euoutp01e
X-AuditID: cbfec7f1-f793a6d00000326b-02-5a7c181cd0ac
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
Message-id: <0810d6fc-dd82-dda8-8c35-d37e8a346599@samsung.com>
Date: Thu, 08 Feb 2018 10:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
In-reply-to: <20180207214338.7n2somaul2msgf2a@rob-hp-laptop>
Content-transfer-encoding: 8bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3eu13N6e2qeVBJGhQoqGUGNzNRKrj4V/1jOqJaen2ULzaV
        NEExHc5XPtJMIzMff8jUnCYmIjjNJ7hMcWn4CMmFmg+0SMts253gf5/zO+d7vuccfiRGTxPO
        ZEx8EiePl8VKhNZ45+CuztMV0qXnOtW+TFbuD4Jpq2wlGP2OgWBqBsYJZurnhpApXSjGGZ3u
        rYhRldSLGM3SNMFMdr8UMpW6XgHzpjEHY5oH5kRMg35CwBz0dIkC7Vj1KzViJ4sKBWx17guC
        1TSphOxC/pCAba/PYIs6mhC7rTl1g5Ra+0dwsTEpnNw74J519Gp3Np5YwDxa3/9LZCK1Zx6y
        IoHyhRaNQcjzSfg432pka5KmGhCsZi9agm0EtdMLxKFiq2TDzDTViGBwjDWxmDoBv8vmcRNj
        lDt83ynFefEygnez62aBPRUCu18qkIkdqNPwR1lBmIowahmHrE9z5jmERvV++4yQ7xoA6rk6
        kYlx6gzotpVmB0cqFGrLv5kbWVH+0Jy9RfDObtA3ZbBM4QRPcmbMUwDVIgLDXqaAX+EaNGz2
        W9geVoY6RDy7wmRZvkWQj2C0V4XxwTMEupVJi+Iy9A9NWOxsobTzubGINL6LIVdJ8yUslLTs
        YTwHgbJtC+NvMSWA0a/DeDFyqzpys6ojN6s6skXVkS1eI7wJOXDJirgoTuHjpZDFKZLjo7zC
        E+I0yPjbxv4NbXWhjWE/LaJIJLERb156LKUJWYoiNU6LgMQkDuIex3QpLY6QpaZx8oS78uRY
        TqFFLiQucRJfkSrDaCpKlsQ95LhETn6YFZBWzpnI7laNX5Z6Vfu+vF1/cfZXp/NOSgB9YXw+
        sD1PVpfhdfa+S4DPYl3lyNWnq8pSjzxEF9h8WLuZu1YXdhDkeqBz3K+PhODI2dqwxYZq9eem
        tAkPQ3iZveqO8Nj19aXb+vIHQaGR3E6I14bWVjW2eZzqL/Qc4az6PCnQew8Gh7tLcEW07LwH
        JlfI/gM9hDORaQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xq7oyEjVRBnsahCyaOt6yWmycsZ7V
        4vqX56wW84+cY7W48vU9m8Wk+xNYLM6f38Bu0TlxCbvFpsfXWC0u75rDZjHj/D4mi0XLWpkt
        1h65y26x9PpFJov/e3awO/B7rJm3htHjcl8vk8fsjpmsHptWdbJ53O8+zuSxeUm9R9+WVYwe
        nzfJBXBEcdmkpOZklqUW6dslcGW83tXCUtBjUfHu7x/WBsY1ul2MnBwSAiYSHye+Z4WwxSQu
        3FvP1sXIxSEksIRR4v/BW+wgCV4BQYkfk++xdDFycDALqEtMmZILUfOMUaJ//29GkBphgTCJ
        n7engdkiAooSv9umsYIUMQs8Y5E4924PI0THFSaJRxf7WECq2AQ0Jf5uvskGscFOYs3dxWDb
        WARUJc5/bgOrERWIkOhcOR/M5hSwkVjb8hHsVGYBeYmDV56zQNjiEs2tN1kmMArOQnLsLIRj
        ZyHpmIWkYwEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzACNx27OeWHYxd74IPMQpwMCrx
        8H6wrI4SYk0sK67MPcQowcGsJMK7R7QmSog3JbGyKrUoP76oNCe1+BCjNAeLkjjveYPKKCGB
        9MSS1OzU1ILUIpgsEwenVAPjpr7X67ff+nPzfoqNxeEPRTZb371u+J+7v79M4s4RK7PHf7yn
        b/c4evvVzRWla17fzc/8M7vaaIbfgoxN5X9Fvy99Fjvtx5+2wjVOp6xquNus1phwX1pq2Ttt
        9d2WgCNTYy4lTipvWnH0+SGvB11zlc1vcYYxn/3/juOZe8zFm7f/rEq/Okn2QY0SS3FGoqEW
        c1FxIgBbWBLHvAIAAA==
X-CMS-MailID: 20180208092756eucas1p2e9c9af2b5479ad99beb4288e95eded47
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1
X-RootMTR: 20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1
References: <20180131134435.12216-1-a.hajda@samsung.com>
        <CGME20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1@eucas1p1.samsung.com>
        <20180131134435.12216-2-a.hajda@samsung.com>
        <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
        <a9745020-602b-8274-e2d6-63295f5b3caa@samsung.com>
        <20180207214338.7n2somaul2msgf2a@rob-hp-laptop>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 07.02.2018 22:43, Rob Herring wrote:
> On Mon, Feb 05, 2018 at 10:06:35AM +0100, Andrzej Hajda wrote:
>> On 05.02.2018 07:08, Rob Herring wrote:
>>> On Wed, Jan 31, 2018 at 02:44:31PM +0100, Andrzej Hajda wrote:
>>>> These bindings allow to describe most known standard USB connectors
>>>> and it should be possible to extend it if necessary.
>>>> USB connectors, beside USB can be used to route other protocols,
>>>> for example UART, Audio, MHL. In such case every device passing data
>>>> through the connector should have appropriate graph bindings.
>>>>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>> v2:
>>>> - moved connector type(A,B,C) to compatible string (Rob),
>>>> - renamed size property to type (Rob),
>>>> - changed type description to be less confusing (Laurent),
>>>> - removed vendor specific compatibles (implied by graph port number),
>>> How so? More below...
>>>
>>>> - added requirement of connector being a child of IC (Rob),
>>>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>>>   by USB Controller in runtime, downside is that device is not able to
>>>>   report its real capabilities, maybe better would be to make it optional(?)),
>>>> - assigned port numbers to data buses (Rob).
>>>>
>>>> Regards
>>>> Andrzej
>>>>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>>  .../bindings/connector/usb-connector.txt           | 48 ++++++++++++++++++++++
>>>>  1 file changed, 48 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> new file mode 100644
>>>> index 000000000000..02020f5d760a
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> @@ -0,0 +1,48 @@
>>>> +USB Connector
>>>> +=============
>>>> +
>>>> +USB connector node represents physical USB connector. It should be
>>>> +a child of USB interface controller.
>>>> +
>>>> +Required properties:
>>>> +- compatible: describes type of the connector, must be one of:
>>>> +    "usb-a-connector", "usb-b-connector", "usb-c-connector",
>>> Nit: one per line.
>>>
>>>> +
>>>> +Optional properties:
>>>> +- label: symbolic name for the connector
>>>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>>>> +  non-standard (large) connector sizes: "mini", "micro"
>>>> +
>>>> +Required nodes:
>>>> +- any data bus to the connector should be modeled using the OF graph bindings
>>>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>>>> +  the connector. Since single connector can have multpile data buses every bus
>>>> +  has assigned OF graph port number as follows:
>>>> +    0: High Speed (HS), present in all connectors,
>>>> +    1: Super Speed (SS), present in SS capable connectors,
>>>> +    2: Sideband use (SBU), present in USB-C,
>>>> +    3: Mobile High-Definition Link (MHL), present in 11-pin Samsung micro-USB
>>> This is un-muxed unlike Type-C where the signals are muxed with USB SS. 
>>> That makes me think the Samsung connector should have its own compatible 
>>> string.
>> Do you mean, sth like:
>>     connector {
>>             compatible = "samsung,usb-connector-11pin";
>>             label = "micro-USB";
>>             ports {
>>                     #address-cells = <1>;
>>                     #size-cells = <0>;
>>
>>                     port@3 {
>>                             reg = <3>;
>>                             musb_con_mhl_in: endpoint {
>>                                     remote-endpoint = <&mhl_out>;
>>                             };
>>                     };
>>     };
> Yes, basically.
>
>> Or should I add "usb-b-connector" extra compatible and "type" property?
> type would be micro? I think type and "usb-b-connector" are fine if this 
> is a superset like a USB3 SS micro connector.
>
>> I slightly prefer my approach(less different bindings), but I am also OK
>> with the above.
> How do you know it is a Samsung connector then? Just because you have 
> port 3? I think it is better to be explicit.

OK.

>
>>> Can we go ahead and define the video modes of Type-C? Normally, if 2 
>>> data streams are mutually exclusive, then they are a single port with 2 
>>> endpoints. So we'd either have 2 endpoints on port 1 or we stick with 
>>> port 3 is always video. We can still know what is mutually exclusive 
>>> based on the compatible. 
>> I am sorry, I do not understand what you mean. Port 3 is present only in
>> 11-pin Samsung micro-USB, USB Type-C has only ports 0, 1, 2.
> So video on Type C would be on port 1 (SS), endpoint ? ? That's not 
> defined in the binding and I want to define it.

USB type C does not have dedicated video lines, it has only: HS, SS, SBU
(and optionally CC) data lines[1] and in my RFC I have modeled data
lines as graph ports. If USB-C interface controller supports alternate
mode (currently there are specs for DisplayPort, HDMI, MHL alternate
modes, but there can be more), SS lines can be used to transmit video
data (or any other type of data defined by alternate mode), but it means
there will be SS mux somewhere before connector, for muxing USB-SS and
alternate lines. So yes, video will be at port 1, but this is still port
for SS lines:

USB3 --> MUX --> CONNECTOR
DP -------^

I do not see why we would need separate video port.

[1]: https://en.wikipedia.org/wiki/USB-C#Cable_wiring

Regards
Andrzej

>> Here is list of possible ports depending on connector type:
>> - USB 2.0: HS
>> - 11-pin Samsung micro-USB: HS,MHL
>> - USB 3.x type A,B: HS,SS
>> - USB-C: HS,SS,SBU
>>
>> All ports have separate lines, so they can work simultaneously.
>>
>> And regarding MHL on standard micro-USB connector. MHL and MUIC will
>> share HS port, but there will be mux somewhere before connector:
> That's another case I hadn't considered. I was mainly thinking just how 
> to handle Type C.
>
>> - in MUIC, in this case MUIC will be the parent of the connector, and
>> there will be graph from MHL to MUIC to describe MHL link,
>> - in MHL, in this case MHL will be the parent of the connector, and
>> graph between MUIC and MHL to describe HS link,
>> - dedicated mux to MUIC and MHL, controlled by gpio pin, it could be
>> handled by MUIC's external-mux gpio property for example, or (probably)
>> less hacky by separate node for mux,
>> or as additional property in the connector (who should be the parent of
>> the connector then? Probably MUIC?).
>>
>> Regards
>> Andrzej
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

