Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3903807-1520838433-2-13267813252167771305
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520838433; b=Daub9wnPoEL0BZemTXyLDVxPpbRjjVsgJ0Is6q/UeQ/0rXe
    grK0st2Sm1XQ17gMqgCzgKPaJ/86dLmYlqDbFpN4lM774vAfsLs8OszvdcFdIIfW
    x94mlUSVyzSxwxxn8hJBL3Nn2KkHC21cPwxw82d0I5fhCc8YCWovFEpiK8W3A18W
    iuQAre7mBNBjHxHKbNP4qiHNx8YuAHqNVaZIbn1LWCmUKjfv8XN+8XPOW+YgKzAC
    lV8CmxM91vQ1e71wgioB7wU8IR2VTR8Umh88uA3/718+QfVsGRLmhcuC5JBrQkIU
    H7PMZk3whbtEKzYS3znAKuZrKlTgNowjVVn3GKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1520838433; bh=6wkVJfFZ
    AucCrZ7APy+aHO/GwKhZ76R7YwOpLQSu3r0=; b=iEC7VpDYymqBB/Yx1jqCbnmp
    XY2iJ6mFsRa8wUhTO6Jzw+HLoQu3XlpRWrNKnHDxY4ubspUqimP346ZFM3qvcgef
    oVI4nZlw7KkAt3LfMvjA5dUh5AQMY9/y8J4qKnctlfwghapxl+zETNhnj17Bd+hn
    3Mwa0p3xwOKMVeC036YkvO/jE+9OzigFbCokApVd/ud3CYOT3NUvnukCQDwLVQLe
    6Vh4ixbagF+oDoI5IAjlu4uWJ/1MMi4Dj9sRtul1MEziFCLd7XNJLLPLcQNbX4G7
    4vlLXRSqiCwzMy0FVx4/1AUNYa4Y4aEfsrG9s4Ukr0y0IG/hixsFFN3RVzPKlg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=uOEVgpDC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=uOEVgpDC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932703AbeCLHGz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 03:06:55 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47131 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932694AbeCLHGu (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 03:06:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180312070647euoutp01e7085b0566e39f82ea7cecf4c26bf388~bGnlj5PT51736717367euoutp01-
X-AuditID: cbfec7f5-b5fff700000028a9-b5-5aa62705ea6c
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
To: Roger Quadros <rogerq@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <3503bb79-e9aa-360d-adb8-767f68ba5330@samsung.com>
Date: Mon, 12 Mar 2018 08:06:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzHfe95nrun49q3k/WRpjkatQrT5rv5laE9/zDMpt0MR08/5jrc
        dZGGRFxFKqNcPy7WVVqJiyLUnHQz9APrl7VEJlfnx+pYK+F6Mv33+nw+38/7835vX5aSf2a8
        2RhNHK/VqNQKsZSuaRptCWIWlyiXtTUvIskGB0Nu51YxpGPkE0NMjc0MeeP8KibZvZk0aWm5
        JSGpWcUSYvnQzpDXdflikttSLyLXS1IoUtnYIyHmjjYRSXnUKCHn3weEYq6isAJxrzMuiLg8
        w1WGs5SnirnedJuIqy4+yWXcKUecrbNWxA1b5m91U0pXR/DqmHheu3TtXml0d8oV5lB78NGB
        wfN0Ekr3S0NuLOAQSK4tY9KQlJXjMgSj30y0UIwgeNFpooRiGMFp+4To30r9/YtTK6UIvjvs
        EqFwIPjRMcy4Xs3G26Hr6TjtYk98Agaz8iYfUfgGDSk9ZZRrIMb+8Ku6S5yGWFaG10LF0xBX
        m8Z+YGyqntSZg8Ph2uWPyMUy7AHPrvZParrhdXBzonBShsK+UOvIn2Iv6O43iVy3AGex4Cwt
        kgi2N8K7mnFG4Nlgt92Z6vvA7/umqWiJ0DWQTAvLBgS9Y+fEwmAVPLG1MS6j1F/TVXVLXQh4
        DbQ+9BDQHTodHoIFd8iuyaGEtgwMZ+WCxgLofXmXEtgLzK1OcSZaaJwWzDgtjHFaGOP/s0WI
        LkdevF4XG8XrVmj4I8E6VaxOr4kK3n8w1oL+fsDnEzbnPVQ/vs+KMIsUs2S5FrNSzqjidQmx
        VgQspfCU2akSpVwWoUo4xmsP7tHq1bzOiuaxtMJLtnvJCaUcR6ni+AM8f4jX/puKWDfvJHSM
        f1U3d8z9unUosC7IX1MrDbudNNpXkpV/evGqU48hYuiXpWNsONT/QrLPce8vD1YHXAqJ3By4
        43hB99szNwrXpA/lFTfkxW37bQ61VD6xr+SiN+RE7lLtPOXRZyZbfhZ/C3My662bDofpm0zq
        mTN8o3cWGPx8+P6yAr36XvhIYoOC1kWrlgdQWp3qD9SoIUx8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xe7os6suiDJ5NYrRo6njLarFxxnpW
        i+tfnrNazD9yjtXiytf3bBaT7k9gsTh/fgO7RefEJewWmx5fY7W4vGsOm8WM8/uYLBYta2W2
        WHvkLrvF0usXmSxa9x5ht+h5pOUg4LFm3hpGj8t9vUwesztmsnpsWtXJ5nG/+ziTx+Yl9R59
        W1Yxehy/sZ3J4/MmuQDOKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTub
        lNSczLLUIn27BL2MW63TWAuu6VW8eN3D0sDYrdrFyMkhIWAisW9nP2sXIxeHkMBSRom9Uzew
        QyTEJXbPf8sMYQtL/LnWxQZR9JpRYtqEqywgCWGBIImbR/+wgCREBBoYJT4+PA82illgNYvE
        hi0dzBAtC5gkHj/fCdbCJqAp8XfzTaBZHBy8AnYSa46agIRZBFQlZh3bzApiiwpESHSunA9W
        zisgKHFy5hMwm1PAXmLdv3lgJzELqEv8mXcJypaX2P52DpQtLnHryXymCYxCs5C0z0LSMgtJ
        yywkLQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIExv22Yz8372C8tDH4EKMAB6MSD++M
        TUujhFgTy4orcw8xSnAwK4nwvmJeFiXEm5JYWZValB9fVJqTWnyI0RTouYnMUqLJ+cCUlFcS
        b2hqaG5haWhubG5sZqEkznveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgTHr2buz3Rx8XGwPIjav
        N7XyXqHFGHhYju3Y7uA9UW6fVprd7VJJ2JawYXIfa5mXw7L3Try7aphv1pVfrvO4se9vf2Pi
        x8OPLntp3tjH5Xlw+QaDRiYbrcQH7QlVPpfjz66R+Nrqt0zqmydTmavQ1VW/zi11s0v8ZX5f
        6OE7n9JrcnUmkaFXA5RYijMSDbWYi4oTAS+AjdsRAwAA
X-CMS-MailID: 20180312070644eucas1p28f6c0a6efb49321192922a8bd0e3c925
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180312070644eucas1p28f6c0a6efb49321192922a8bd0e3c925
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
X-RootMTR: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
        <20180227071134.28063-2-a.hajda@samsung.com>
        <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
        <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12.03.2018 08:02, Andrzej Hajda wrote:
> On 09.03.2018 11:24, Roger Quadros wrote:
>> Hi,
>>
>> On 27/02/18 09:11, Andrzej Hajda wrote:
>>> These bindings allow to describe most known standard USB connectors
>>> and it should be possible to extend it if necessary.
>>> USB connectors, beside USB can be used to route other protocols,
>>> for example UART, Audio, MHL. In such case every device passing data
>>> through the connector should have appropriate graph bindings.
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>> v4:
>>> - improved 'type' description (Rob),
>>> - improved description of 2nd example (Rob).
>>> v3:
>>> - removed MHL port (samsung connector will have separate bindings),
>>> - added 2nd example for USB-C,
>>> - improved formatting.
>>> v2:
>>> - moved connector type(A,B,C) to compatible string (Rob),
>>> - renamed size property to type (Rob),
>>> - changed type description to be less confusing (Laurent),
>>> - removed vendor specific compatibles (implied by graph port number),
>>> - added requirement of connector being a child of IC (Rob),
>>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>>   by USB Controller in runtime, downside is that device is not able to
>>>   report its real capabilities, maybe better would be to make it optional(?)),
>>> - assigned port numbers to data buses (Rob).
>>>
>>> Regards
>>> Andrzej
>>> ---
>>>  .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
>>>  1 file changed, 75 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> new file mode 100644
>>> index 000000000000..e1463f14af38
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> @@ -0,0 +1,75 @@
>>> +USB Connector
>>> +=============
>>> +
>>> +USB connector node represents physical USB connector. It should be
>>> +a child of USB interface controller.
>>> +
>>> +Required properties:
>>> +- compatible: describes type of the connector, must be one of:
>>> +    "usb-a-connector",
>>> +    "usb-b-connector",
>>> +    "usb-c-connector".
>> compatible should be just "usb-connector"
>>
>> Type should be a property
>>
>> type: type of usb connector "A", "B", "AB", "C"
>> AB is for dual-role connectors.
> I have proposed such property (and size also) in my first RFC [1]. Rod
> did not like it :)

Ups, ugly typo, I meant Rob, of course.

Regards
Andrzej

>
> [1]: https://marc.info/?l=devicetree&m=150660411515233&w=2
>
>
>> micro super-speed and high-speed connectors are different. How do you differentiate that?
> I am aware of it, and property differentiating it was also in my earlier
> iterations.
> If there will be need to differentiate such connectors, adding property
> max-speed or max-mode would do the thing.
>
>>> +
>>> +Optional properties:
>>> +- label: symbolic name for the connector,
>> Why do you need label? We can't maintain consistency as people will put creative names there.
>> Device/bus driver could generate a valid label.
> It follows convention for other connectors: HDMI, DVI, ....
>
>>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>>> +  non-fullsize connectors: "mini", "micro".
>> type is misleading. Type is usually A/B/C. It should be size here instead.
> As you can see in discussion for previous iterations it follows
> convention already established for other connectors.
>
>> size: size of the connector if not standard size. "mini", "micro"
>>
>> If not specified it is treated as standard sized connector.
>> e.g. for Type-C there is no mini/micro. so size doesn't have to be specificed
> Few lines above it is described: should be specified in case of USB-A,
> USB-B non-fullsize connectors.
>
>> What about Type-C connector?
>>> +
>>> +Required nodes:
>>> +- any data bus to the connector should be modeled using the OF graph bindings
>> s/modeled/modelled
>>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>>> +  the connector. Since single connector can have multpile data buses every bus
>> s/multpile/multiple
> OK, I will fix both typos.
>
>>> +  has assigned OF graph port number as follows:
>>> +    0: High Speed (HS), present in all connectors,
>>> +    1: Super Speed (SS), present in SS capable connectors,
>>> +    2: Sideband use (SBU), present in USB-C.
>>> +
>>> +Examples
>>> +--------
>>> +
>>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>>> +
>>> +muic-max77843@66 {
>>> +	...
>>> +	usb_con: connector {
>>> +		compatible = "usb-b-connector";
>>> +		label = "micro-USB";
>>> +		type = "micro";
>>> +	};
>>> +};
>>> +
>>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
>>> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
>>> +
>>> +ccic: s2mm005@33 {
>>> +	...
>>> +	usb_con: connector {
>>> +		compatible = "usb-c-connector";
>>> +		label = "USB-C";
>> The label is not consistent with the earlier example.
> Why?
>
> Regards
> Andrzej
>
>>> +
>>> +		ports {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +
>>> +			port@0 {
>>> +				reg = <0>;
>>> +				usb_con_hs: endpoint {
>>> +					remote-endpoint = <&max77865_usbc_hs>;
>>> +				};
>>> +			};
>>> +			port@1 {
>>> +				reg = <1>;
>>> +				usb_con_ss: endpoint {
>>> +					remote-endpoint = <&usbdrd_phy_ss>;
>>> +				};
>>> +			};
>>> +			port@2 {
>>> +				reg = <2>;
>>> +				usb_con_sbu: endpoint {
>>> +					remote-endpoint = <&dp_aux>;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>>

