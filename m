Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3106191-1517473201-2-16177074335994292784
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
    t=1517473201; b=HMe81AMmltehAPwcOVXrj7Z074ycQ2ov7sHe8HNW0apSnpb
    eKP6q7ljy/65VSlJUGmu86OL4ZmxpaXn/EosS37OUTNEh8QEoGxI3O8iIqzN8pAh
    Nbq0KaJOY5XruSZSZv5aQqAs2e2DsiPzyfGUWalZpqVx92LnhsF/yVMVS+GB0OSp
    8+OhOkmlfyVed7oq0VreZ/nzjxAiO0bTHXrkkOodu82wnYz59523/MT7jdcyx2tN
    MZlUf2xJBOKthFYTHQqKTitw+OWWnQ51VsqZHyxU+1O0E3Xx1VIIntt5N/0+tE1W
    z+2g4S1kWSFo05AQP/J2c4lKVcF49ltrzesj5LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1517473201; bh=85kYszfB
    delsoh4wMDGbbk7ldMfH03OwOOkQQKPODxw=; b=sxfxyIyph7KztC0kjOk427wh
    5zGSq7hlbRqMAd0wzUulummd4dA+3yZNyt5Sn/uISUWDmics7OdOEdAhgvXpGmTi
    7GKVd1MCPeKHYUzhGL1wJO/aienHk05/txVR/bs0cdZw6KBSpi73AmlDJ31LedlE
    Axse7UWuJZul0Q40vvj6U5qWz3XYZfrH6kBYchM+1cIBlNda9fZ8N50n31exbcx2
    r2Voi+vbntAyLf8s1nIeS4TYDWfVqDXaYygnqmyXjhJDGa3gDNUYb8QyhX2FrfM0
    TXlyjEY9tHWicxKqRG3tjUuzMHEWmxKmNJlh7MAEoWDOxxXl9VBo5y7ZhqWuMw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=PhIUZvXf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=PhIUZvXf x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751753AbeBAITr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 03:19:47 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42712 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeBAITp (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Feb 2018 03:19:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180201081942euoutp0263b918a1257f1d267200dec1e1913c04~PJdHCUOgR0724507245euoutp02N
X-AuditID: cbfec7f4-f790c6d0000075d3-ec-5a72cd9de8ea
Subject: Re: [PATCH 2/2] arm64: dts: exynos: add OF graph between USB-PHY
 and MUIC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-id: <6581962f-3552-2891-e6b3-b2f7c0018c93@samsung.com>
Date: Thu, 01 Feb 2018 09:19:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.5.0
MIME-version: 1.0
In-reply-to: <CAJKOXPewrA38bxiCKa=pjhVKXys2KRstV2w=+MP3TVi9kkN1kw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
Content-language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djP87pzzxZFGdxv5LHYOGM9q8Wxtifs
        Fte/PGe1mH/kHKtF8+L1bBaT7k9gsTh/fgO7RefEJewWl3fNYbOYcX4fk8WiZa3MFmuP3GW3
        WHr9IpNF694j7A58HmvmrWH0mN0xk9Vj06pONo/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllq
        kb5dAlfG19lP2Qo+81f8auxkaWD8x9nFyMkhIWAisfTRYjYIW0ziwr31QDYXh5DAUkaJld+f
        MUI4nxkljpyexArT0f3zO1RiGaNE0+KpUM4zRolfJzqZQKqEBUIkzv7fBNYhIqApcf3vd1aQ
        ImaBdywSa3c8BkuwASX+br4JtpxXwE7iz7FFzCA2i4CqxN5jU9hBbFGBCImuZ7tYIWoEJX5M
        vscCYnMKBEvcObwfbBkz0JwXXyaxQNjyEpvXvGWGsMUlmltvsoAslhCYzC7RvKQJ6gcXieZ5
        79ghbGGJV8e3QNkyEp0dB5kgGroZJT71n2CHcKYwSvz7MIMZospa4vDxi6wQK/gkJm2bDhTn
        AIrzSnS0CUGUeEgca3gADVZHiS0dn1khYdTAJHHt4ib2CYzys5B8NAvJF7OQfDELyRcLGFlW
        MYqklhbnpqcWm+gVJ+YWl+al6yXn525iBCaw0/+Of9nBuPiY1SFGAQ5GJR7eF5cKo4RYE8uK
        K3MPMUpwMCuJ8L7ZVxQlxJuSWFmVWpQfX1Sak1p8iFGag0VJnNc2qi1SSCA9sSQ1OzW1ILUI
        JsvEwSnVwKjw8MWPbcV6l1YI+PE9bS206nzZ7dK5iG/JuhVubAvYFn6JvDL5auJrW3W5k7vT
        I+z0Lu2viCm41+QV/11W7o6RVvfCiJuGJut11CMlfuRZ7ZzB82O5yQlmGVFteSN+dpWTXLsZ
        9mpW5kn/iYgM9M36tbBiYcrqgJRnVadu7Dc9zxOkcv2gkxJLcUaioRZzUXEiACDxrelcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xq7pzzhZFGZw8rGexccZ6VotjbU/Y
        La5/ec5qMf/IOVaL5sXr2Swm3Z/AYnH+/AZ2i86JS9gtLu+aw2Yx4/w+JotFy1qZLdYeuctu
        sfT6RSaL1r1H2B34PNbMW8PoMbtjJqvHplWdbB77565h9+jbsorR4/MmuQC2KC6blNSczLLU
        In27BK6Mr7OfshV85q/41djJ0sD4j7OLkZNDQsBEovvnd0YIW0ziwr31bF2MXBxCAksYJR5v
        W8QO4TxjlJjZvpgFpEpYIETi0L7zrCC2iICmxPW/31lBipgFPrBI3PtwhBGio4lJYt6UZrAq
        NqCqv5tvsoHYvAJ2En+OLWIGsVkEVCX2HpvCDmKLCkRINM2cywpRIyjxY/I9sG2cAsES+1tP
        AMU5gDaoS0yZkgsSZhaQl9i85i0zhC0u0dx6k2UCo+AsJN2zEDpmIemYhaRjASPLKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMAo23bs5+YdjJc2Bh9iFOBgVOLhfXGpMEqINbGsuDL3EKME
        B7OSCO+bfUVRQrwpiZVVqUX58UWlOanFhxilOViUxHl796yOFBJITyxJzU5NLUgtgskycXBK
        NTDO33Pl1A2J619K6tna5qZ9cXN4dJ3drP2A+NR/TG/+8aZ1Lpx/WmzmN4Y7O/3K/ScuXuno
        l/Wf5/TdCzI3k+58Y0tbkyHS9GPdbLf1H/dNmzT5wdVks6QdSzhzbbIEd84Im/eQferPQwpG
        C+T3x37eoZpw/ZLxZamW510NOzJ+Wzxors495ZJ/QomlOCPRUIu5qDgRAMgyFAquAgAA
X-CMS-MailID: 20180201081940eucas1p14bc912df6c1fc26491a1795f491c7c2a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180131155734eucas1p1c7988ce46f3164329a39d2358d9fada9
X-RootMTR: 20180131155734eucas1p1c7988ce46f3164329a39d2358d9fada9
References: <CGME20180131155734eucas1p1c7988ce46f3164329a39d2358d9fada9@eucas1p1.samsung.com>
        <20180131155718.5237-1-a.hajda@samsung.com>
        <20180131155718.5237-3-a.hajda@samsung.com>
        <CAJKOXPewrA38bxiCKa=pjhVKXys2KRstV2w=+MP3TVi9kkN1kw@mail.gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01.02.2018 08:50, Krzysztof Kozlowski wrote:
> On Wed, Jan 31, 2018 at 4:57 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> OF graph describes USB data lanes between USB-PHY and respective MUIC.
>> Since graph is present and DWC driver can use it to get extcon, obsolete
>> extcon property can be removed.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> index 427ff861b441..b20b42659206 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> @@ -828,6 +828,17 @@
>>                                         };
>>                                 };
>>                         };
>> +
>> +                       ports {
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +
>> +                               port@0 {
>> +                                       reg = <0>;
>> +                                       muic_to_usb: endpoint {
>> +                                               remote-endpoint = <&usb_to_muic>;
>> +                                       };
>> +                               };
>>                         };
>>                 };
>>
>> @@ -1242,12 +1253,17 @@
>>
>>  &usbdrd_dwc3 {
>>         dr_mode = "otg";
>> -       extcon = <&muic>;
> Look ok for me.
>
> Does this depend on #1 patch for DWC?

Yes, it depends. #1 adds code to find extcon using graph, without it
dwc3 won't be able to work in dual-role mode.
Alternatively, I could split this patch into two parts:
2a. adding graph bindings.
2b. removing extcon property.
In such case only 2b depends on #1.

Regards
Andrzej

>
> Best regards,
> Krzysztof
>
>
>

