Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1088053-1520237923-2-17721152752499353258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
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
    t=1520237922; b=vSCjEJJheiRgv7SMSJXxbya9t5D9rK+ME5Xvn7UXhFUaBBy
    e35f2NKyZP/uDO0KUeSNu9OqBHqLmzEoaBc/9f9IL6dDsZ334ZJYEva48mhLH54T
    mZ3qyrxiNLvOBlGQakII9ujCgNlCU/rgHsbGqFbZNMHFiJ3Ub8l6Tc7QA/FcBdCS
    0OSqcSaIqDTK+9LGcPSapwObyK4xezHu0hGQ5XaV5rAbh2HPMY8V3uojQQle2ose
    hEFBKPVyvkb3jo9AmYMtZNeb1rFCrQSdCLv+vZrovOs9BpqxFuFjMp9XtfKNEp4a
    ngnZkeNHQDb6xd6kwuNcjKAUDymThVvxmItwQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1520237922; bh=RabL2ufF
    t5//JE8Y6Gyz+yGMxFum7zuLQcUAE2QMhr4=; b=PWiPzYNl2j4aYusIX81uHtVQ
    tSDY+TuXt2g9xPVJUMZdc+j1lvU4CVF3C8xFj7/HUO5eyZc2t0kEwfdJJAnzloIf
    iBFBCPFM+1O10mKNpwIlE8U36TWTRvE1gwKwJSRYrLlthphb1nmaj2qN7ua+WYDW
    R3kV8yxNXPV1ECEz1lJ4iP5wrA69Ivz5yPxA8j03qEdy03HD+1e7ftsDph5a9ZMv
    8oJroSIOlujqr+B217tIuzJsWsJso261cHpFPbInRUmxSFJTlvvQwZZGDFG7j7pH
    NY2FjU52OuHYey2kAyFFOo+SxBac0zE5/OdvvZQ6qrq2o5l5j/hauLiulpuCng==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=pgRYFPP6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=pgRYFPP6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeCEIS1 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 03:18:27 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34167 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752300AbeCEISR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 03:18:17 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180305081815euoutp02ee98f1d90ea9b404da7aa87d83dc14b1~Y_E-B7bVc1762917629euoutp02I
X-AuditID: cbfec7f2-1dbff70000011644-1d-5a9cfd45a44b
Subject: Re: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
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
Message-ID: <8434f820-5016-1e5a-c3cb-5d7789dd69c1@samsung.com>
Date: Mon, 5 Mar 2018 09:18:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302131315.GA10598@kuha.fi.intel.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUiTURTHu3te9mw0uU7Dg71Iqw9aqElFFyyJiHjoQ28QxD6kKx8tdMu2
        NDVQGaVzla43Mhvq7E2X5pxmJlqxLClRM8s0KovMdDmClpSllfNR8tvv/M//f885cDlK6WaC
        uYO6I4Jep0lWsXK64fF4V/iWSat6lbsaEaPJw5DaohqGvPr+mSGlrZ0MeTH2lSXmm3dpcnbA
        QpOuLoeU5J+5KiXOj70M6WmysqSo656ElF8/QZHq1rdScu1Vt4ScaGmVbsR8VUkV4nsKTkv4
        y6ZLDO+057N8yZOd/MDJNglfdzWbL6i3I97rXLJDppavjxeSD6YJ+siYOPmBG0VPqRSjf/pw
        cymdg44rzEjGAV4D76+4KTOSc0pcgWDkTQ8Si+8IztvMUp9Lib0IbC1oNvF8rEwqmm4g+NWb
        y4iFB4Gj8w/rcwXgXdD/aIL2cSBeC9WWymkThU0MvJsolPgaLA6Dybr+6YACx8C48QzjYxov
        h3M/v0zzArwHbBc+IdHjD08uDU4/KsProLK+nfIxhUPgjsc6w0HwerBU4hsG+DQH3lGjVNx7
        M/z9lsuKHADutvoZfRG0nztFi3wM+oeNtBg2IRj4nTcTiIaHbd1TG3FTE8KgpilSlDeAtcci
        8cmA/aDP4y/u4AdnGy5SoqwAU65SdC+FgY7blMhBcO3ZGGtBy4rnXFY855riOdcU/59bhmg7
        ChJSDdpEwRClE45GGDRaQ6ouMWL/Ia0TTf3A9j9t3xrR2PN9LoQ5pJqvaNRZ1UpGk2bI0LoQ
        cJQqUJHmnZIU8ZqMTEF/KFafmiwYXGghR6uCFHtDs9RKnKg5IiQJQoqgn+1KOFlwDsp0rtrW
        RzLqf1jGrbc+BCS0RNXkV2zt8+bJL8dN3t/cGz6yN3go/WKvdTRsnivWE6qWV4SF+0U8IIMv
        y8d3L2a127O2JpR3BIY8sxVmx92PDEkyf3Wttlcl1sreD5Yl/aCiJ9xDmxy23MMRpc0NDsvv
        lFr/gvQqx0q/fDsxlnSraMMBTdQKSm/Q/APmgmsTfQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsVy+t/xu7ouf+dEGez5pW3R1PGW1WLjjPWs
        Fte/PGe1mH/kHKvFla/v2Sy6Vu9ksZh0fwKLxfnzG9gtOicuYbfY9Pgaq8XlXXPYLGac38dk
        sWhZK7PF2iN32S2WXr/IZNG69wi7g4DHmnlrGD0u9/UyeczumMnqsWlVJ5vHvJOBHve7jzN5
        bF5S79G3ZRWjx+dNcgGcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2
        Kak5mWWpRfp2CXoZy2ecYi5oEqx4sWc+SwNjC28XIyeHhICJxKWvC9i7GLk4hASWMkpcP/yF
        BSIhLrF7/ltmCFtY4s+1LjaIoteMEufeTwUrEhYIkrh59A+YLSJgKrF2wkpWkCJmgS5WiZXf
        tzFDdLxglFi/bxE7SBWbgKbE38032UBsXgE7iZ9NE1lBbBYBFYnJP16D2aICERKdK+ezQNQI
        Spyc+QTM5hQwl1i55TTYScwC6hJ/5l2CsuUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJ
        ywJGllWMIqmlxbnpucVGesWJucWleel6yfm5mxiBcb/t2M8tOxi73gUfYhTgYFTi4RUonBMl
        xJpYVlyZe4hRgoNZSYS37DNQiDclsbIqtSg/vqg0J7X4EKMp0HMTmaVEk/OBKSmvJN7Q1NDc
        wtLQ3Njc2MxCSZz3vEFllJBAemJJanZqakFqEUwfEwenVAPjommVgT/NPErfe2uLzJ54i7Ot
        t3ir7DnmkKOPhWffTb9w/Ij/lYg/f5v9BNMblgdFvT8nrXcmqOjhk3JhR+M2oxXft3O62k+s
        fHE8faGx0R/JRI+Hyneqt9+0rNx587BMvLxdU5umQJgNs8Brk12Odns67rpF50d7Pi288rn+
        m8/evIfPZz9UYinOSDTUYi4qTgQAckgfQBEDAAA=
X-CMS-MailID: 20180305081813eucas1p2cb7681c81c1057f1a606de0108b63d3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180305081813eucas1p2cb7681c81c1057f1a606de0108b63d3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
X-RootMTR: 20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
        <20180227071134.28063-2-a.hajda@samsung.com>
        <20180302131315.GA10598@kuha.fi.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02.03.2018 14:13, Heikki Krogerus wrote:
> Hi,
>
> On Tue, Feb 27, 2018 at 08:11:29AM +0100, Andrzej Hajda wrote:
>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
>> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
>> +
>> +ccic: s2mm005@33 {
>> +	...
>> +	usb_con: connector {
>> +		compatible = "usb-c-connector";
>> +		label = "USB-C";
> Is this child node really necessary? There will never be more then
> one connector per CC line.

But there can be more connectors/cc-lines per IC, for example EZ-PD CCG5[1].

[1]:
http://www.cypress.com/products/ez-pd-ccg5-two-port-usb-type-c-and-power-delivery

>
> We should prefer device_graph* functions over of_graph* and
I guess you mean fwnode_graph* functions.
> acpi_graph* functions in the drivers so we don't have to handle the
> same thing multiple times with separate APIs. Is it still possible if
> there is that connector child node?

Bindings proposed here are OF bindings, I suppose the most important is
to follow OF specification and guidelines and these bindings tries to
follow it.
It looks like it should not be a problem for fwnode framework to handle
such bindings, but it is just my guess. I have not seen any fwnode*
specification I am not sure what is the real purpose of this framework,
but it seems to be just in-kernel abstraction for different firmware
standards (OF, ACPI), so even if it lacks at the moment some
functionality it should not be a barrier for OF bindings.

Regards
Andrzej

>
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
>
> Thanks,
>

