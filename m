Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3370786-1519799999-2-5474300910478334407
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enca, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519799999; b=ba8JoZ0zEtMPk8OXPwWjYzQxtqH4DzrTxZbixOxA9tdZMBQ
    U+p8o/G0+Z/njCNiI2QISeAHWPHQNP9xC+47KdQpdu5Ia29yL3eh6TlllDyLNuGL
    ld5T+IOjPNu0iWczAtHPaQTkYQ8/btu3zfAwhR9X8nYC5oIctNON+aG0ToiNFaZk
    9bmsc1fVcF1V+TQ89ZzH+x/5SUkY+Bky8CljgL97zLSSu0bCKpABYilvVAg6YIYs
    K7NorfyCRK7bZbEZoQX82ckw7r+xMSI3pE/cc/2bw93+fiVP5uTjmIp0dv5dwwKI
    HhqT+72EGblTqgyn+mggS6K8hT+sddSHmP4bU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1519799999; bh=5Ua8Q8fl
    VHGxjNkEUdTRjFbYYL+7iQklYcyQQzeIMvg=; b=LGydL5bYeFMcCe2Q0YK0m8IY
    WRAiewgMUVVoqhytsHBZ7dxLIJhSViypQXlp2T6Nh8qd7up+s7ZuyK0K/0E7v5F7
    gWZT6VcaTckvbG5RYQAOs7p3rKJyvBdbgDxUbyYeflgDPM6QMYugz8/RUNm1D1Xa
    Ht72tyUhJeG0zPOKbkiU+zeNCjsww2Jfl7NenVexfe6Wt8ePuSW3T+pye5ooYc14
    n0/UGO/+QdxOv2613uImhh4Gs7UiRivAFimn4nNjNyu5KucfZrf82Jmudrr9eFvG
    s5NPkLIENJ3/8C26YyvFPbLTIea59iaDsicAiJyX8NlV0F2BvhDf5f6td51ecg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=FwWNWZS/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=FwWNWZS/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeB1Gjo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 01:39:44 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33141 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeB1Gjm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 28 Feb 2018 01:39:42 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180228063939euoutp01d77d51753871dd37aed2b2dc56add7f3~XageJLF7p1874018740euoutp01G
X-AuditID: cbfec7f5-b45ff700000028a9-2f-5a964eaac6d5
Subject: Re: [PATCH v4 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
To: Rob Herring <robh+dt@kernel.org>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <be8fe638-03c6-c0d1-4c30-1a8f9a195968@samsung.com>
Date: Wed, 28 Feb 2018 07:39:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKGVwvqu36D57WbB7bPMt2tOZmvq+ukFuNHbhgiWYuw-w@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRj227nsOJodp7IXi8RVkkZqJHTAioiKFdntR8QIa9pBJTdtx2t0
        kcjw1vB+mSNTZubwni7TtFJzldiUWaZQkpcCYSpNKbMi3VHy3/M+l+99H/goTDJBeFJR6jhW
        o1ZGy0gRbupdtOwynixUBD7PwZnbaTaCaSyuJ5jh+W8EU9bzjmCGFmZJJncsG2cslgYhk55j
        EDJNEx8IxtqmJ5liS6eAqXiYijG1PZ+ETOXwoIBJ7egRHtwor7lfg+RW7T2BvDSthJA3GdNJ
        +VimWSB/bLgl1zYbkdzetOU0pRDtu8xGRyWwmoADl0SRSyXNZKyFTrLOVQlTUJsoAzlTQAfB
        +0oDkYFElIR+hCB15ruAH+YRdH+ZWlXsCGwdJmwtkqnPwHihCkFr9m0hP9gQ2PMmyBWXG30B
        Ggf68RXsTm+Dhm+jjgRGTxJQYyxzCCTtC38ejzgCYvoAVNhyHDxOb4eCr1bHOg/6PJQXTCHe
        4wpvSiYdHmf6DDyrK3VgjPaCJzY9xmMpjE6WOUoA/UcItuoWgr/7MJSbPq92cINpc7OQx5uh
        Ly8L5wOZCN52pmP8kI/AMm0V8K5g6DYPLr9ELa/whfq2AJ7eD9NL+eQKDbQLfLS58ke4QK6p
        CONpMaTdlfBubxjrb1k9QQqVAwtkNtqqW1dNt66Obl0d3f+9DxBuRFI2nlNFsNweNZvozylV
        XLw6wj88RtWElr9e31/zQivq/B3WhWgKyTaIX6gKFBJCmcAlq7oQUJjMXdzhWaiQiC8rk6+x
        mpiLmvholutCmyhcJhWH7ripkNARyjj2CsvGspo1VUA5e6ag6GNYkE+od3tE3os7IV4/tRx1
        tWf2YGHtYvWcYKTr1UhD6SF9bhjpV9w6H5gUc2qnyrwY3o77XLp+vVMWHOak35tl0hmdPH5k
        BabUJi+8Vvyy79vQv7P5xMxSYjDgdc8N71+WDmUk9JoNfkeOnrvxNIBKDtmjrT9+NrYooWK8
        YVyGc5HK3X6YhlP+A13qYGt2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsVy+t/xe7or/KZFGbzYoG/R1PGW1WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Swm3Z/AYnH+/AZ2i86JS9gtNj2+xmpxedccNosZ5/cxWSxa1sps
        sfbIXXaLpdcvMlm07j3C7sDvsWbeGkaPy329TB6zO2ayemxa1cnmcb/7OJPH5iX1Hn1bVjF6
        fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJfxe+YWtoLzAhWXPyxnb2DcxdXFyMkhIWAi0T2ni7mLkYtDSGApo8T3xonMEAlxid3z30LZ
        whJ/rnWxQRS9ZpS43DCPESQhLBAjsfHCWRYQW0RARWLD81tgDcwCz1glNv+PhWhoYpJY3XiK
        DSTBJqAp8XfzTTCbV8BOYtHbiWDNLAKqElOfXQZrFhWIkOhcOZ8FokZQ4uTMJ2A2p0CgxJ51
        s1kgFqhL/Jl3CWqZvMT2t3OgbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz23
        2FCvODG3uDQvXS85P3cTIzDGtx37uXkH46WNwYcYBTgYlXh4M7KnRgmxJpYVV+YeYpTgYFYS
        4d0rNS1KiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OB6SevJN7Q1NDcwtLQ3Njc2MxCSZz3
        vEFllJBAemJJanZqakFqEUwfEwenVAOjh/Yt4Tc1p3Q6tJXS8i2Wi7TZRHJeWP5F3DNquV6C
        pP6mFSkHnu//mcG9VvXTuZatV39wBOi0q/yTPN63bNcEe75Qnm1VMWvi3+U6+RuGbv2u6hL8
        qTqnfq7St6nBb1N0TT7tDFh0tfn3z9UPH26+8+xLY29qmfXh99rcamsFpr6f5P/k6fWZSizF
        GYmGWsxFxYkA/xsFhQcDAAA=
X-CMS-MailID: 20180228063937eucas1p26784966357b0351f7a3956f19d7de9e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180228063937eucas1p26784966357b0351f7a3956f19d7de9e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085607eucas1p1a08c82fac832049d79705b4222422fa9
X-RootMTR: 20180221085607eucas1p1a08c82fac832049d79705b4222422fa9
References: <CGME20180221085607eucas1p1a08c82fac832049d79705b4222422fa9@eucas1p1.samsung.com>
        <20180221085541.14556-1-a.hajda@samsung.com>
        <20180221085541.14556-5-a.hajda@samsung.com>
        <CAL_JsqKGVwvqu36D57WbB7bPMt2tOZmvq+ukFuNHbhgiWYuw-w@mail.gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27.02.2018 22:24, Rob Herring wrote:
> On Wed, Feb 21, 2018 at 2:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> OF graph describes MHL data lanes between MHL and respective USB
>> connector.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v4:
>> - added missing reg property in connector's port node (Krzysztof)
>> ---
>>  .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 32 ++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> index f604f6b1a9c2..2ed506df94d0 100644
>> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
>> @@ -817,9 +817,22 @@
>>                 clocks = <&pmu_system_controller 0>;
>>                 clock-names = "xtal";
>>
>> -               port {
>> -                       mhl_to_hdmi: endpoint {
>> -                               remote-endpoint = <&hdmi_to_mhl>;
>> +               ports {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +
>> +                       port@0 {
>> +                               reg = <0>;
>> +                               mhl_to_hdmi: endpoint {
>> +                                       remote-endpoint = <&hdmi_to_mhl>;
>> +                               };
>> +                       };
>> +
>> +                       port@1 {
>> +                               reg = <1>;
>> +                               mhl_to_musb_con: endpoint {
>> +                                       remote-endpoint = <&musb_con_to_mhl>;
>> +                               };
> These ports are mutually exclusive, right? If so, it should be 1 port
> with 2 endpoints. Ports should represent independent data flows.
> Something muxed or replicated (1 to many connection) should be be
> endpoints.

No, this is HDMI -> MHL bridge, so port 0 is HDMI input, and port 1 is
MHL output.

Regards
Andrzej

>
> Rob
>
>
>

