Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB73C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3589B2170E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="eO5RyS1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3589B2170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeHUSCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:02:09 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:44045
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727439AbeHUSCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JlH8obH7osVrBSyZSZKdyGZ7HZTc0cTrfRqA3pdnEs=;
 b=eO5RyS1FPBKWatip+VbS1h5Pbgvkle04FoxlNA4pfHIkcMkE7CUF0mqRlPox2+UIRmdafjAWZIVhP+Y0UTeLv1ecS89bERvtBIHG7deYHs17Df6Hbei0+nYljP6JfcDXlNoMKzLVbi8bevq2W7FRCeBz+pyrS8vXPNZYpiMjsWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from iota-build.ysoft.local (89.24.100.190) by
 AM6PR04MB4661.eurprd04.prod.outlook.com (2603:10a6:20b:1b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.21; Tue, 21 Aug 2018 14:41:03 +0000
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@karo-electronics.de>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output between PWM and GPIO
Date:   Tue, 21 Aug 2018 16:38:52 +0200
Message-Id: <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: HE1PR0301CA0012.eurprd03.prod.outlook.com
 (2603:10a6:3:76::22) To AM6PR04MB4661.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c446380-e5fe-41b9-6fbf-08d6077420e7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4661;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;3:LVNlxYPB6MMuk9whCOSYIqebNo0S91eWez5J33M7kNBbBgvRbOU+cwCSYAh1MOT4olD7rAUp33YPMAtWeByD+ls8QOSe17iXGsUbpmBxhUUCOWeSfyTZLyU9glGkcOqjbnX115u1qs2zYwoh5TdvpxVbMxWL44uZVzPMbA0x+fvxgt0C/mWswK+kvJEDO87PRZfHwabr5Jr2rI1gYYanNQAmJ/xptmFr27cS5dgzKJ2djtANenuQsodbr0JSZJ5T;25:kMLGxT/rnMpzeSfeyv8JhDUdqcQBq46sPPgphQhvMLO7FTWKoZSls01+eO2G7xyWvhG5o8uQweMQ/f7/bDv5+iod6dowuBVQhWrE+G4BrGWDbjM7mPluDcC5u/3BUnjltg8BKvWkYvkHpay40+M1vVppJXNB8MD4U/JsDTx8RwIVM6meSb9dc5m8UAQfvEYrb+j3aXo3Q5QQDNywU7Gjxs8SO356Z/MengD+bVBPfoc315X1S+NxAKsJYxLGFHyrxBJmPeUvsjE5OV+0YbYG/GGYYKqs9xSwJB7uaV46PsmjQ9XeoL1oW5Hl4ALlr0fepJCFhsZAz31mitQEYuBkwA==;31:7Lm618WftaYEgRCXCDhoXLG6ds4MHcxYK7Hiu07EEt8TUjQri1I/vzTDF4dwW12VXIqXBQt9ZHgHXuP3nlRjPOSGTyB+jxL5lia3w5WrZE+GsRSoDETDSBwbt7ao1TGKD0t+wvY9PDchu1HDAoFHep3aaBuldYPEhu+QZvzO86OEP2YnX1NVNhw1TkEeVPVQtEll9IN3cN5hJy5pWSNwDlnjukKirIg9CfeJxoA9QIo=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4661:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;20:wfYzLNKxND2sC1jrdz0V1DVl1EquqDHgnF8y5dXvHMQ99vxtRNXzDOW0K6mkIohqiL+4NZ25JdqI0HkCP+ckbb/4JUSOkDVOc3ropumNpjH/8PKbeOOyi/rbD4rqipRn+4yPDMU9ZbDyJlalB5e7+yy9/vTLfqOzCqN7eK12OHzMHK2OLO8wmHikD7G3reANo7qr5gj1lDvEElpItTTC/n2fRzjOWxbMrsikoKQbRfEuccmIX30sCmoIj4Uki8ij;4:k76Z3QCBlfvQIT+47CnnpZjENC3Zg1UIHXOiW1buOV0xIUhQQiP+kPELMXU4DE4lluFfW15KHUAXsqjA1X497KvJgvakCyeAhHblDjSrFUg6rysmZkN9wrtEus10E7TnwKVFVFOWi4YbRW2DsVT7VSWaWMX3fEYMdrUINmznNOxqpWIOJndfetYoKCIKSfrvyrm4IT2JrAw5PMS+CSuLQTwSG/s4C3wEnd0g4XK+8qbIIvecElFnVotKs/TuCaUwLodthtG7y+9NQLAtvybhjw==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4661D63A4CEFBCA8805B39419E310@AM6PR04MB4661.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:AM6PR04MB4661;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4661;
X-Forefront-PRVS: 0771670921
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(7736002)(39060400002)(107886003)(2870700001)(2906002)(25786009)(23676004)(76176011)(52116002)(54906003)(106356001)(50466002)(110136005)(305945005)(6666003)(105586002)(4326008)(86362001)(316002)(72206003)(6506007)(217873002)(66066001)(81166006)(81156014)(8676002)(47776003)(2616005)(6486002)(14444005)(6512007)(486006)(53936002)(6116002)(476003)(956004)(26005)(68736007)(8936002)(478600001)(50226002)(36756003)(446003)(186003)(386003)(97736004)(16526019)(5660300001)(11346002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4661;H:iota-build.ysoft.local;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYxOzIzOm45NU9SNDY3QlVsT3BuQ2F3UzhtWE43cFJG?=
 =?utf-8?B?dGxFOGdvMCsyeWY5bksvR2pLais5S3Z4VTh0dEJaUXF6bzVuTGV2cDRzWjFO?=
 =?utf-8?B?YzZjSkNIcUdYMjA3ZW1rNHVJU0g1TlcvbytmVmR5WERhdjI2YmVnNk1UZjdN?=
 =?utf-8?B?cnF3Tk9OdlF4Q2Q5Q0RJR0kxQ3pHaXVocDNuYW4vWmc0dk90dnNPK2hnN3ox?=
 =?utf-8?B?TmFPNVpEUW4rb1ZHdVozSERkMzZZZVhDR3RjWlFmTVRkSVZIVXZkMTBocHhi?=
 =?utf-8?B?RzhuUVBxQnBGM0dlckY1TDRkWFVUTU5PaVdOZHlUb0hscUFhZkZWeFhxN3hI?=
 =?utf-8?B?dDdqMm83WE92WG82UmtnQjBjampmTVhSaFU3bStsNithMlY2eXUzN3Rldi90?=
 =?utf-8?B?ZjR1V1VBdzNVOFRSbUhZb2lVdm9JL3FKcDQwUnhlMHNKSHZWMnJOL205dWpQ?=
 =?utf-8?B?dGFyRnprbmNHYXRralV1cW0rS09pamxKaDJNQ25lbEtiNlVrK0Y4dGNRclpy?=
 =?utf-8?B?VUZHVWE4cnl2UmFqU3UyZGFlbENBclBlZUVpS0kyeTBuaVVLbTd6aFhZcnA4?=
 =?utf-8?B?M0JXVDUxZFBHd1c1YnFXeXVIdGpSNkZHaEpTVGtzSm54VkpPNFVPRi9FS2hI?=
 =?utf-8?B?b2krTlR5Uk01cHNEMWYrY0k3cERITk56ZG1ibGFOcE9UZlBDaTFsUFo1Lzlj?=
 =?utf-8?B?RXl4dnM5NHRLVmVmYVVHTlVjL0pWTXg3cXd3OEZTYjdYSWhRWjdoMjByN1RX?=
 =?utf-8?B?Sm0yL1U2RktKZnZBU2pzdnBTa1lKc09taU1VMDJ3OUhHYXRNS3hVM25oNE9o?=
 =?utf-8?B?Qlh6VFl2dTZ1MzJQRTJmaXFQVGYwTlhhOEh0bEdTN1o5aEpvVDEwbDRPZmpl?=
 =?utf-8?B?dFpXcWtTQWhhNmF3Qy9iVFU4R0s5N3NWaWpkMDlQUFQrS2dIN0dURWJwRC9I?=
 =?utf-8?B?REVzNlNuanc0ZGRjV2QzYU50WjkxZ3UxUnBZdk1qc1pLRnU5QW50OXZRaTUv?=
 =?utf-8?B?UnhFQzVKTStuaDZGM3QxL2hKd29BWDZJRVFxMnBrcklvNkRJNGp5S1dSREsx?=
 =?utf-8?B?QkxHNHlEbVRmVGoyQytWQkYzNHdWcDl4NHFpNHJIY0MybmJLWnh2MHlkNzUv?=
 =?utf-8?B?YUtOSkxWUkEvZHNsdkc1VXRnQVViMDQvaWFJQWNvb21uUEJyYmd0Y0JVQUZU?=
 =?utf-8?B?QXNwNnRySDgwNTYyekltNmNXQ1BFTnpMalB4cklNMWhWaGZqR2FzRVRkMDlw?=
 =?utf-8?B?cU8rd01scHM4a0w5eFFCUmE4bGE4OFB6N0dYQXlSVHEyMzc2eWxRNUdrMmQ4?=
 =?utf-8?B?MUZIN3B1Nm85SEtNSXhsb0ZkVjlDYnducTZ3alhxU2NNdjFtem05MUZwK2tr?=
 =?utf-8?B?VGtUYm1BWTJ0b3kwVjk3QytpWXlwQXJ1WFlPQm9zRVRSYnpMUmtmR0pmdGlB?=
 =?utf-8?B?QUowdW5rT290V25Dc09LN2xuakczUHQ4ZTJWbkYydnZ3ZE9mclFoallCc25o?=
 =?utf-8?B?OERQZWxtOE9BeTZrMzZHd0FQNlF4c1pMdFBsMVdLeXpEWDBLNDlVbGdmUGw2?=
 =?utf-8?B?cWVCSGtCMVl1bHhkbzJQNnlTNFFuOW9yeXFKV0Z2cElYT29Ia1hUMUo3cFVz?=
 =?utf-8?B?cVRQQjIwbk02ZzNVMW5GZlBSTFY5eU02MTRLZGpPaUlUQUx0aG56TmR1ZldP?=
 =?utf-8?B?Z0REa1VINjh6YmZrTXNENUdiVmcyVGRjdUk0WThNTStSaVFqeFYxWDF0REhU?=
 =?utf-8?B?TG9QTU1Fb2VwbHRNV1JZdz09?=
X-Microsoft-Antispam-Message-Info: WeJLNyc2O5U+yqIjIt4afWKF/tMWdt5lOguE14CCWZm4DffSFKHW3rquvzyWusZ7IsBwviwlinJ3RYE4vZazrD7G7DNQj0ZGvqjUp+YwCyKOxa/9NXe9L83lWUQHJGOQY4wNhLbE7wShz0L4PJlXEcbNUxIjDEVL963HZp5X3Up+bEmr4zmqqdLwgE0y1WGbhhutc3l741tqMWDBgSB9obJ9EMmmQ8nsN9pc5PUEgccum6Uk0SE5T7mDjRs78PcU1XxPBESzjkz4amWRC5+miU0mJpeTDpevgKez1aMUlbLiQqJMwBz3A7OA0sB7ZY+wVR0JySaLET9y0suceAqbJlr0Nf/VeoenSo9bDZJyLbc=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;6:2H3+9wp/U7oI6AP+YPEpzOuwTjwYlP3A5Ok9CHBeeaxkMgctDzDfox6lslgskNX1R3E9xPYoWO53+9D9AOSVXMHmgTaZxRsM7gKbq2NkdUuhc5PKbFRMjsw1dtFDjLnthnEvYIgGs0wXSnUsVNMEaB8Ax1AENlcTioPd2gp4j1S0FpoNd/mpd65SeIbIbky+z3CzDKaPXHWL8uFZM3wyPkON7KNPCO1FZP9UTMhzKKYkRMPlhY5CxYJ//DhIjuO1je2SIKLbZ61rR7o8Gk5h97GRjwSaASPx1kT6jNj+tu30LPMIG39awsCx3r3z0evDIETulHyoLUGvBHDLvgpaCmzeeVjO+ZuND8O2VY/Hs3swAaUSomo7E+fXfI/ZDsExCj1QE4SrLyHUiy+kfgFqMioe4FDNpGnG3d3g3JGMjPVWijtHS07zNWd1x81PAJgZzoXZMHQVpyanY8OULzli5g==;5:MwFFdKunM0UkYNNQWUJLoEncN2WiyvBq8I+uSjgi9YTh2Cij60K+1l7b6t0d9bPwcmWr74jg43i4zUUMReRMgfbfMVlXi9jYRg0Mtiu+fYGihmcFt/tZzJQesyjtfXdQVzB/emzV+9XPut3nezGCxezxZZbXrtd92vQVhsOKSkA=;7:3lKEvR4hl+1F0LX57QNAjg11xXM9vEKr+G4ouv3mjyz6zMngGnS1bXpWtew1eJXPKtv+pp157ZkG/rJL12NvoUrQ+A0eQrX8rj68/9Y9Fbfbo7xAGCmQiaelVrAM0D/k76UB4wrR+SB8RPohWnldqFn0F4iP1A6Q+EFPMbB7iOLulQrJE9GKU5//DZO1AAYrg7N9p5rTaSkoBrjyk/MRxiwS/iEd7gXhY2SrX1s6xLI2s2jOJMEzeudbIorXlmCe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2018 14:41:03.3307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c446380-e5fe-41b9-6fbf-08d6077420e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output of the PWM block of i.MX SoCs is always zero volts when the block
is disabled. This can caue issues when inverted PWM polarity is needed.
With inverted polarity a duty cycle = 0% corresponds to solid high level
on the output. If the PWM is dissabled its output instantly goes to solid
zero which corresponds to duty cycle = 100%.

To have a trully inverted PWM output configure the PWM pad as a GPIO
with pull-up. Then switch the pad to PWM output whenever non-zero
duty cycle is needed.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
index c61bdf8..3b1bc4c 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
@@ -14,6 +14,12 @@ See the clock consumer binding,
 	Documentation/devicetree/bindings/clock/clock-bindings.txt
 - interrupts: The interrupt for the pwm controller
 
+Optional properties:
+- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
+  pin to gpio function.  It allows control over the pin output level when the
+  PWM block is disabled. This is meant to be used if inverted polarity of the
+  PWM signal is required. See "Inverted PWM output" section bellow.
+
 Example:
 
 pwm1: pwm@53fb4000 {
@@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
 	clock-names = "ipg", "per";
 	interrupts = <61>;
 };
+
+Inverted PWM output
+-------------------
+
+The i.MX SoC has such limitation that whenever a pad is configured as a PWM
+output, the output level is always zero volts when the PWM block is disabled.
+The zero output level is actively driven by the output stage of the PWM block
+and can not be overridden by pull-up. It also does not matter what PWM polarity
+a PWM client (e.g. backlight) requested.
+
+To gain control of the PWM output level in disabled state two pinctrl states
+can be used. The "default" state and the "pwm" state. In the default state the
+PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
+is configured as a PWM output. This setup assures that the PWM output is at
+the required level that corresponds to duty cycle = 0 when PWM is disabled.
+E.g. at boot.
+
+Example:
+
+&pwm1 {
+	pinctrl-names = "default", "pwm";
+	pinctrl-0 = <&pinctrl_backlight_gpio>;
+	pinctrl-1 = <&pinctrl_backlight_pwm>;
+}
+
+pinctrl_backlight_gpio: pwm1grp-gpio {
+	fsl,pins = <
+		/* GPIO with 22kOhm pull-up */
+		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
+	>;
+};
+
+pinctrl_backlight_pwm: pwm1grp-pwm {
+	fsl,pins = <
+		/* PWM output */
+		MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
+	>;
+};
-- 
2.1.4

