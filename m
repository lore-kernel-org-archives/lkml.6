Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755546AbeDWOe2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:34:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:50112 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755451AbeDWOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:34:09 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180423143404euoutp0100b28c364c6d663baa63e809c0383f51~oF0G2LkoO0253202532euoutp01p
X-AuditID: cbfec7f5-f95739c0000028a9-4c-5addeedabb3e
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v7 2/6] regulator: bindings: Add properties for coupled
 regulators
Date: Mon, 23 Apr 2018 16:33:38 +0200
Message-id: <1524494022-22260-3-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsWy7djP87q33t2NMrhxi8Ni44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bZ
        CYdYCu5xVhy5toapgXENRxcjJ4eEgInE2xVzmboYuTiEBFYwSvx/cZYFwvnMKHF7/29mmKqd
        f7dAVS1jlLjcdpMdwvnPKDF74k+2LkYODjYBLYk17fEgDSICNhJvbxxgBKlhFuhnlpjc1MoC
        UiMsECLxYJsdSA2LgKrEknt/WUFsXgEXibnT30Etk5O4ea4TzOYUcJVY0vwAbJeEwA42iVNL
        J7NAFLlIvPw+jQnCFpZ4dXwLO4QtI3F5cjdUTbXExa+72CDsGonG2xugaqwlPk/aAraAWYBP
        YtK26cwgt0kI8Ep0tAlBlHhI3J4zEWqMo8TmTddZIf6dwSix9foc5gmMUgsYGVYxiqeWFuem
        pxYb56WW6xUn5haX5qXrJefnbmIERvbpf8e/7mDc9yfpEKMAB6MSD+8O3btRQqyJZcWVuYcY
        JTiYlUR4H74BCvGmJFZWpRblxxeV5qQWH2KU5mBREueN06iLEhJITyxJzU5NLUgtgskycXBK
        NTAm57EJd+SyrW/dvbFvuvSN0pvliy9qX9242lIqNvzyjoebZ2/4+HimZNoRG02xnQcWNOx6
        vH5lhoK65uebhvvXFpzKSmLksbbjnr7oyHR21TXyWiz3H+9fwJOQrl2tkT3P9GRg7IHdsu90
        m+eHlq39kix9rHF+wMnL8gcy7pvY8B2uZqma+3OpEktxRqKhFnNRcSIAsIjOA+gCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOLMWRmVeSWpSXmKPExsVy+t/xy7o33t2NMvi0w8hi44z1rBZTHz5h
        s5h/5ByrxdllB9ksHl71t/h2pYPJ4vKuOWwWC17eYrFYe+Quu8XS6xeZLFr3HmG32H/Fy4HH
        Y828NYwe375OYvGY3XCRxWPnrLvsHptWdbJ59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8bZ
        CYdYCu5xVhy5toapgXENRxcjJ4eEgInEzr9bmLoYuTiEBJYwSrw8cJcdwmlkkrixei5rFyMH
        B5uAlsSa9niQBhEBG4m3Nw4wgtQwC0xklli4+ApYjbBAiMSDbXYgNSwCqhJL7v1lBbF5BVwk
        5k5/xwyxTE7i5rlOMJtTwFViSfMDdhBbCKhm375dzBMYeRYwMqxiFEktLc5Nzy020itOzC0u
        zUvXS87P3cQIDL5tx35u2cHY9S74EKMAB6MSD+8O3btRQqyJZcWVuYcYJTiYlUR4H74BCvGm
        JFZWpRblxxeV5qQWH2KU5mBREuc9b1AZJSSQnliSmp2aWpBaBJNl4uCUamCcH/hd6FKb+8+a
        VrWzrUfMWSdcb9vwXrrvU0awQfrritN6tcVnvJexzw3ac1fl4J7+eys3Hld25N//Ydm7qoZV
        GiIvd0wXvu2hbfpnWeLPvU9POkUWLvwomGj1c76pQdbk7Peu97ddvHjlizxTqOK0FY7MbXGV
        t9ryDTM+rWg5+P1XXv9XTR8+JZbijERDLeai4kQAx1+hBzoCAAA=
X-CMS-MailID: 20180423143400eucas1p1bde12f792993806e9e88277177b59dfb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180423143400eucas1p1bde12f792993806e9e88277177b59dfb
X-RootMTR: 20180423143400eucas1p1bde12f792993806e9e88277177b59dfb
References: <1524494022-22260-1-git-send-email-m.purski@samsung.com>
        <CGME20180423143400eucas1p1bde12f792993806e9e88277177b59dfb@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some regulators require keeping their voltage spread below defined
max_spread.

Add properties to provide information on regulators' coupling.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 2babe15b..a096fae 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -68,6 +68,11 @@ Optional properties:
 	0: Disable active discharge.
 	1: Enable active discharge.
 	Absence of this property will leave configuration to default.
+- regulator-coupled-with: Regulators with which the regulator
+  is coupled. The linkage is 2-way - all coupled regulators should be linked
+  with each other. A regulator should not be coupled with its supplier.
+- regulator-coupled-max-spread: Max spread between voltages of coupled regulators
+  in microvolts.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.7.4
