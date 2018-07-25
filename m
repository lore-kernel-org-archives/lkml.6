Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC27C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC74820843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="t4cVxvwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC74820843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbeGYPjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:39:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38616 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeGYPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:39:06 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180725142708euoutp01a57a9c0d13d2bc84837bdc5403bbfe66~EotmJD2mo0950309503euoutp01k;
        Wed, 25 Jul 2018 14:27:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180725142708euoutp01a57a9c0d13d2bc84837bdc5403bbfe66~EotmJD2mo0950309503euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532528828;
        bh=lhsEa4pns/IX4JqxjoFVIIeHM3y5YMt6Y4uatPnM6Gg=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=t4cVxvwiXrI5eWqo08LkGlw6PHUKs6ZBB9xETcHm3XkePD0E9gfuhtLibaOBzocw2
         Ftiplyl+vUCgHKtAC3b9jj12K+VQY+xcGhUJQG6SCQmSEsscn6TkkrEqVRSXHOQQwt
         BhtNpmuXouPXXNy8TkNLSa9D76c7u7+l/5HyP68g=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180725142708eucas1p2862bd49a90c48819589b432c1a71c19f~Eotl1Cast1219612196eucas1p2M;
        Wed, 25 Jul 2018 14:27:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 50.BD.61560.BB8885B5; Wed, 25
        Jul 2018 15:27:07 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180725142707eucas1p25bf4bc7b63babc0732db13ae9a79d983~EotlIYFCy2848328483eucas1p2S;
        Wed, 25 Jul 2018 14:27:07 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-62-5b5888bb0f5e
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 99.DA.04178.BB8885B5; Wed, 25
        Jul 2018 15:27:07 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCF00AU2ET71J60@eusync1.samsung.com>; Wed, 25 Jul
        2018 15:27:07 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     "J, KEERTHY" <j-keerthy@ti.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] thermal: ti-soc-thermal: fix TALERT IRQ handling
 for DRA752
Date:   Wed, 25 Jul 2018 16:27:06 +0200
Message-id: <2243156.HcYyxvpmOE@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <fd458da1-75d6-84ed-838a-0495045fad77@ti.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7djPc7q7OyKiDY7d17GYf+Uaq8Wp7U1M
        Fpd3zWGzmL2kn8Xic+8RRosnD/vYHNg8ds66y+6xeM9LJo/jN7YzeXzeJBfAEsVlk5Kak1mW
        WqRvl8CV8fHmNJaCcxwVxzf8YW1g/MHWxcjBISFgIrFgXnwXIxeHkMAKRomba++xQzifGSUa
        l65l7WLkBCu68PgwG0RiGaPE+Y47jBDOb0aJK6d6WUCq2ASsJCa2r2IEsUUElCUeLG0A62YW
        WMwo0d/LDWILC0RITG/8zwxiswioSvQ8ms4GYvMKaEq8P/gALC4q4CWxZV87E4jNCTSzqes8
        M0SNoMSPyfdYIGbKS+zbPxVqvo7E2WPrwA6SEFjBJnHz7zJ2iLNdJC7OXA5lC0u8Or4FypaR
        6Ow4yATRMJ1R4s2vpSwQznpGiTVnjjFBVFlLHD5+EWoFn8SkbdOZISHGK9HRJgRR4iHxZtVH
        JkhQdDNJfNmwjm0Co8wsJNfOQnLtLCTXLmBkXsUonlpanJueWmycl1quV5yYW1yal66XnJ+7
        iREY/6f/Hf+6g3Hfn6RDjAIcjEo8vB/swqOFWBPLiitzDzFKcDArifC6HAYK8aYkVlalFuXH
        F5XmpBYfYpTmYFES55X2iYgWEkhPLEnNTk0tSC2CyTJxcEo1MNZ9NHY6YFl7/FZ3b9lHR3tz
        wWqhv04M56vzNjFFzplzgPVY0uci8yfVX7RPh4av3LLous2NhOru3n1X7V9VXg1P/6E6+fCR
        1o97MpKMzMO5OcM1kpc0aNnJfMnbyadhoF4eyCzn2LNkb5rQDNflIdkzRR7Or9zA8LFi+8HH
        0444L9HrWXNIVomlOCPRUIu5qDgRAH9Mu7H7AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsVy+t/xy7q7OyKiDdZd4LOYf+Uaq8Wp7U1M
        Fpd3zWGzmL2kn8Xic+8RRosnD/vYHNg8ds66y+6xeM9LJo/jN7YzeXzeJBfAEsVlk5Kak1mW
        WqRvl8CV8fHmNJaCcxwVxzf8YW1g/MHWxcjJISFgInHh8WEwW0hgCaPE51UCXYxcQPZfRokb
        JxexgiTYBKwkJravYgSxRQSUJR4sbWAFKWIWWMwo8W3BH7AiYYEIiVXfJ7CA2CwCqhI9j6aD
        TeUV0JR4f/ABM4gtKuAlsWVfOxOIzQk0tKnrPDPE5u2MEsc7UiHqBSV+TL4HNodZQF5i3/6p
        rBC2lsT6nceZJjDyz0JSNgtJ2SwkZQsYmVcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIEBu62
        Yz8372C8tDH4EKMAB6MSD6+HY3i0EGtiWXFl7iFGCQ5mJRFel8NAId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rznDSqjhATSE0tSs1NTC1KLYLJMHJxSDYyViXVHU//6XLy1QUXaX/hBbaewG6Pe
        zHXSy0rf77nK6fTL8F3k6bRmz2X8i/J4FfcdOZAb2JH9Iy8yZkryyaV755hfXhy+9lWUQkrZ
        222tWU75vYVLe27McGNWiCvL7LL4/7NHbuZtC8d5KaEbnm8JUtt9/mH7p93uRT/3Jd7uZgl4
        tWDJ7CAlluKMREMt5qLiRADv0q1MWAIAAA==
X-CMS-MailID: 20180725142707eucas1p25bf4bc7b63babc0732db13ae9a79d983
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180725142707eucas1p25bf4bc7b63babc0732db13ae9a79d983
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <1526298141-14045-2-git-send-email-b.zolnierkie@samsung.com>
        <fd458da1-75d6-84ed-838a-0495045fad77@ti.com>
        <CGME20180725142707eucas1p25bf4bc7b63babc0732db13ae9a79d983@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 11, 2018 07:49:41 AM J, KEERTHY wrote:
> 
> On 5/14/2018 5:12 PM, Bartlomiej Zolnierkiewicz wrote:
> > .report_temperature is not set in dra752_data which
> > results in temperature updates not being propagated by
> > ti_bandgap_talert_irq_handler() (it doesn't make much
> > sense to handle TALERT IRQ without reporting temperature
> > updates to the thermal core). Fix it.
> 
> ATM no one is using TALERT as the thermal software polls on the 
> temperature. No real benefit from TALERT.
> 
> TALERT is set at different temperature and software polling thresholds 
> come from Device tree and i believe its best for software to go by 
> polling and then act on trip points.

Could you please explain what do you mean by "no one is using
TALERT"?

The code in ti_bandgap_probe() sets TALERT thresholds and requests
IRQ if the TI_BANDGAP_FEATURE_TALERT feature flag is set (and this
flag is set in omap4460_data, omap4470_data, omap5430_data and
dra752_data).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

