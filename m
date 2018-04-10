Return-Path: <StefanSerban.Popa@analog.com>
X-Google-Smtp-Source: AIpwx4+7Q1C44aEMYXTJPpP0VTGn00gP2Tsxbmi7UGuIHC6W5b6srT+27iizNo0YeykdjDUSwWby
ARC-Seal: i=1; a=rsa-sha256; t=1523375944; cv=none;
        d=google.com; s=arc-20160816;
        b=euT+JSfN52y3YF5sTrQio1SoPvdhMAc8bCza4eEM9M5v0fSf6aMfGPRvKHtq2oLiz4
         RMpjgv5kJ0HqkqnQoVAAXeA1UPnZtLvRCrWJaUqlGWCEfjmioNBtzMH2l/EYTH7aUXqb
         vUScoGiGYOWFNF+D0iTQ/Xr9ys4fHYTmX3Z6yxIuFpHfy4pdOma12hsVPlkaIaRgKd+c
         0myDvJvrWFjim9qXTu2WoN+IIWuUDlGqjcBZmAauvpqyytlyGtPkAl4+UaQE73ieQ/lN
         12clDfHR9lriDGOMV3/Rgwv6lsxsVaJzUuz/7oOPXWOB2JZonchFVycarI3R159sdYPI
         PTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=WAJXtCIUAEkWH+wydqy2jr/D9Y4PrGF+M5+HLJdfReU=;
        b=wImI2bjiBbyNyFoapjCXABDq9+XTimi43XSv3CdbBaUTCam8SjIBviepKjThefsnYa
         jKthgopSnhAqX7hzxlf2D3uh80ZBokvAktDsw2ttTzri5xN5aMmAQokLMznzXQHfPSf1
         vaSTJtnvQ5byBi6j/ZftVu7VRg3uOGHbcPBfvTnqXHk9r/Pr2l+1xkcWr9IXW8uoZluE
         c4td5iw1DCRgyfQZXzt/AORYvQ0ikCQO9OwP/okqIOdikVQMbp9HsmM1MGub/5CWNx45
         e+jgQaM2NIRmWMEslTpN1IdRz1GrFYRAMR7H52Os4m3ocgJu69RCpwZ6+BmAmQS60+nq
         wl/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=WLVD2Cpc;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.32.41 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@analog.onmicrosoft.com header.s=selector1-analog-com header.b=WLVD2Cpc;
       spf=pass (google.com: domain of stefanserban.popa@analog.com designates 104.47.32.41 as permitted sender) smtp.mailfrom=StefanSerban.Popa@analog.com
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=bestguesspass action=none
 header.from=analog.com;
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <davem@davemloft.net>,
	<mchehab@kernel.org>, <gregkh@linuxfoundation.org>,
	<linus.walleij@linaro.org>, <akpm@linux-foundation.org>,
	<rdunlap@infradead.org>, <Ismail.Kose@maximintegrated.com>,
	<lukas@wunner.de>, <fabrice.gasnier@st.com>, <mike.looijmans@topic.nl>,
	<kstewart@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v2 6/6] iio:dac:ad5686: Add AD5671R/75R/94/94R/95R/96/96R support
Date: Tue, 10 Apr 2018 18:58:49 +0300
Message-ID: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
References: <1522418209-11927-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(39380400002)(2980300002)(438002)(199004)(189003)(47776003)(1720100001)(2201001)(2906002)(575784001)(966005)(72206003)(4326008)(8666007)(6306002)(36756003)(106002)(316002)(7696005)(426003)(7416002)(50466002)(8676002)(54906003)(246002)(50226002)(6666003)(5660300001)(48376002)(305945005)(110136005)(51416003)(336012)(8936002)(76176011)(486006)(478600001)(16586007)(126002)(186003)(2616005)(11346002)(446003)(26005)(77096007)(476003)(7636002)(107886003)(356003)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2485;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD011;1:DG/cYDqQi970fdzVQjYC4CAAp031JGM36J4oXawe/hSyvscCfA65RvZyIJSoAWXoqZ5j2vfrg3BAqb3TNvUqCfc+inHhBmbw5bnfmrAbTCIecfFRpzr4oTXvRieTGtv+
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2f9b57f-340d-45c9-1bb8-08d59efbf99b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR03MB2485;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;3:iPcrCz23Xq9IolaRIzh34oC2sbBJYYDCcDwCJAoxOdYUpo3e7ehsyzoEfiQP/13PSCuHkRiJ7CuoCkqmJa7lJTfD6k+SXZY75etXYHpXZu8icAJcMIXPRLlKXtHwc7aqoXTMjuHo5h7At9VMJwE3gteaA5RAHliZnW5AAzblnShXrUZeOruGeKqufJy5LercsHZeoj6MOFXasM7w7mXQAwIzV/faOY1TzFOy43X8NewvTiR8aIe0q1puIMgdVDnkf3mlPBpRpY9jVKmqlKKfz+VjrN5jo2wVDbC4JyFEL0JipufzWxJHksRIuf7E6IVVRVdcuj8S8bj0Rpqrm9E7jutyfEbPnNPYaLtV10BPitY=;25:5K+qtbvZS2qxEj4pmjBVb5bEBE8qXRvtr5TEM6uQQNO+MzvdHU6CF2CoKAgWwrcXtvl9KPr1BbyfbipFX9y6p2H4IjnD+ii3rwE8T8nDKYsmnajYdUvR094v8Wms63PPss8svp6QCM2ylayEuStKBXbbFIXLNTbGYwM9bW78uYWAq6nhsoHb0CmW7HXPp7diHeXWXk9b6k4PegoK+5liE8KinC6w2jpzX6GGHgTBcN0dkr+xoa1Ml6aFY9ZyeP0Uf+l9aUKk0E+Eb17QOWwA5+eN2UMj5cKg0RNDddqZdhTx1rkVbvQRnhRN6ItDH6Wl4Dt4pi+6DFK1ArexFyCfEQ==
X-MS-TrafficTypeDiagnostic: CY4PR03MB2485:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;31:Y18sv3Ia0PlmHv739M+APasidb7SZwZ6jN89EKnUcWxKJXvZRWNLNsXN6jyQlHJy/dPCLMcLf6W01wRH/g9djeutOJobMh9Ov0vcTfKUDv8kVvQ/mr/MXIPf8dl3aTn+NTqoM992UijHMfhu1xaTfcH8pwzh7jzyjg4v0HJKCN+6QNBpy7XqzzUYFyWEqZYP4DTSFwORFWLqDeo6E9bzfiVYpjQ/cI19LC/olFBd6Ew=;20:1bsORZ8FCQ4zmu4pEhdBFre9CfWgCr2W1gBCJqgiBDgHNOJLd3VMbHJEhkr9b0SURkwWMSjbWtCDwIokDLFHdH9Hm7csBDCrsp+UA2/XMwamda3bhaq5Oz4byJY7d+LFEFATXl6UTM6MbS+ME//oZ2Kn6HCFmglQ2cu2SMlakDnAe2Pbp1oMquNsMWk5NFEg960msMGNCA7Ujvj4oQUU6neXWP48xLewsJMBgsicUN5S/4EpyUAXmmZehBCTlaugyKZ80Ire/rjlUimIy1TDoj1NFoDsAzN3ShI8cOaATbzc1+lKqF8NA1CYMPhQ2S2HBpFNq8lfWZOsjK7a07DhyN6iPL8Yqs2AfZxTeMUhvr9lTToft7ZTzJHxQtFqAuMtxz1+CRCa6B3mlC4hvhI9XMxzlKGTc1C2m25fZF4FjatTxtcRgwxk88oUNb8UG6O86xJtPcdGcNFn1H50kJqqi7upGoJcTfh33bvKNKhfdOqNBhFRehHQhvyaplFzXUKw
X-Microsoft-Antispam-PRVS: <CY4PR03MB2485365C08BD47EA7367B3299DBE0@CY4PR03MB2485.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(270121546159015)(9452136761055)(232431446821674)(95692535739014)(170811661138872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR03MB2485;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2485;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;4:+bPd/eQGbqhosbO8zUju2BMgHH8JjGW1zpwKF3Wx7JMBUQucCG8uwOVJZoshD+/qZbIzOZXZ7qfYSCDUrj2ywB9p//xKkWOkK+bo6AaHr+t7cmpKE1P49Vj4iHWLae4K9p5w+VzkPOkkNLoZUxfXUEp23Kb2RurFzPVHbIkwg4XSgknSVcXeV6PNIgxSlDlmzRisvCe4XAIdTfH/wVOaTU6qHU9AlM9hNBnm6PFq7nCjLZnMhD4+TNmBJhac9klvzYBdLlHipukQiqza5FGNNtSQZm+H6npVmfrvac0HxAnvCu2Jm2H/lADXSZ2+BEmP4Bs2LG7q7nEMX2m4beMG5Axcvq0IIddO1nibEG6B/E4Y3hetr2lRVaL3yR2z3wzovRX9FGoacovwpho7KSoKnquaqH+QzbD1CKRQuNjGJ441zujNGwkq6tAGfSbqJkHUqPQBcjbKW3UlpJfAKNpxDg==
X-Forefront-PRVS: 0638FD5066
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2485;23:R0jfCgZwYAJv8N/oEZuv8XcFzdg1zU/5ayJIiRq44?=
 =?us-ascii?Q?y+0T2E+Td0BCVEA6AknSgeEARQX3TObFPWLWf9OpSh5fvh+KXk6+ZYSG7Bvu?=
 =?us-ascii?Q?8+fAiELpIB+lbluVjuIyOTpRYilmJYjLEEvfbcRhdp8pEBJHWipfuetmR2L4?=
 =?us-ascii?Q?4DtZ5hqi+APlPPhYzWRDXoQZiPzSBz3SRP7y0VPfu77+vyqLLiZWce1SO2zK?=
 =?us-ascii?Q?PVdzzFG5QsVO/YQ36vKoRNwROszVvodOEylN8hkBscjAwA1l1VcqO0/nl4Uv?=
 =?us-ascii?Q?4ceR1bJONqC57zgJrm1ZMn3JBHQaPqQ8fLPc4ELXLfrwWB1CKJjyOCSckktD?=
 =?us-ascii?Q?m6sojP7yk40PI0I71aFYMUKXi7MKYAPJeeFy5Xf1cIHYtubXRKhm/u9TvRMu?=
 =?us-ascii?Q?332tsyNTuwjxD94v3GctEKRaqqyxDSjzL3qdeOHkCdUHvf9Ky0yhKtiGQqFS?=
 =?us-ascii?Q?o/FtX7PBqnL159OiTMDJBD8g7zi9KUeYmT0TAHQxHQyexHrFM5RGHQxid15e?=
 =?us-ascii?Q?39LMN8hc7FpAlMYQcnlIGUZ6+fSOY8uWR4OkKV6e41+estly4k3slpFAhxXp?=
 =?us-ascii?Q?O6+cg9Ur/1wKhnRuDqPHLAsr/PMOm1WI+W7B4x4qWoa5PCVCG7Ut9LU8wKj2?=
 =?us-ascii?Q?BgDm7mbVqSG45MjSyrnrHd+15fqwfzK9hF5wKlONCWOdIxBodUeV8Unyd6Al?=
 =?us-ascii?Q?RYRg7SwcaFzo27z/uk7pbHJ1wWD2a/ENSmRErIAV6EpXKAm7rVZqodgUxn9f?=
 =?us-ascii?Q?V8Vo5HEWhDUd/dyge9Y/tfI5gceFYUK/VgzJWWtsxHpHe9dnwA4Ju3yVkern?=
 =?us-ascii?Q?/KYy+uNfE/U7cyyN0c7UuIzl8z3aIL+mdpZ2OY0oqzMs49AN9AaQiiudiPgp?=
 =?us-ascii?Q?kzwvmk2AABrKpUFbCFHkUaXfTUMM06cF5/f9Jvmgbpe2a1Gx+9oN/o6g8ZLr?=
 =?us-ascii?Q?CXvnrAWQa2PMGY7DybAoPqv04kKCDO7RcJS2FXRZTHmw5pfUzHznvByuaKj0?=
 =?us-ascii?Q?6mwc26coiavDClrcAB9VdmeRmzDx0gMLz7HWafwkDW03dUz7MgR2ZmgaAAR3?=
 =?us-ascii?Q?HORnISshAVafHxpseBD0oNWfDJ9ooaxjgyec0eaV6Om2fuphAd4zmr2HBAPI?=
 =?us-ascii?Q?VBvngndX9nbKEcx2gxv8E6kzqrFI9Wn4eK3EtTfAOx+7yMXUR7DEB5IOm+FU?=
 =?us-ascii?Q?XZ6vUZ1NAnfTos=3D?=
X-Microsoft-Antispam-Message-Info: KL3eEkJMMQUHW+/zobH96C43brqATiKLReVqIeZHGLBy9hUZAl05saC5cSU3+n5TQldECxkRSk6XbcgmXvXZhMNEt/6dTGhg7JDVSDFaalScxKJdJ9lcP933TuokaW8e5GbSd99EQK7LmNS9NWO45QPdzPu+IWKR8tLpfHTKqtTHC1DIVatBuZHLhsF9n5Mh
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;6:nQrgts0WhDC20UoJwQQ3auwyfzzH8ISVfCK4XZRDIn9WXwTgR05YMJT2hixC6fwELpwVNZ8IgqzMBUoS8WDaZcrI/VCk0HDV/wkQR+BMvW4fcrRz0jZVRi1EY0KiUul2ooJ5ngoJjGUS4J6oNDQTYMBHdxk9GSBVajugaRfaCukQoOxJg5+GhA6AhozeME96zqQ8rG7cWMBLbetvIdXwttfEHKGQfM4gZa2n+5/VAFNap6hGjsHdQrm6xuvFXHx7uqOvbuqWG5+vCIpX9dAAqm/l4vLAy7p4lGCr1k0gicr7fVxfK+EGbKv5QA1YWl314z5Fb7cEdQJW6xt2qiO/WD3CxAzlFBr0sLoZqTLB53CLLO6nx7VzM0YBwuI/nZ/v0SJWYsAGWmS4CiJh83cmbB4Mp5uxfh75TiIFJ014am1mZCJWK7mMFcKphenrwTan3VKY4M6BLanYMF7Y6srakg==;5:6ethwDeWBkV5hQwQZuKs9scxqmDxuPYOT3+5W4B2c+AdHZp+uqmD33HM3OYJbG6raXafpCJgHwIShtQUYP4YPfGfEnkpPoYAYomczF/CT+MOqvCwxCx7PflXCoplD9EFaEJUudYwnkTOuvBaydHXd13xQc4sJxW4aHLqjs7ncQw=;24:j9xMOh2X6jhIZRy5iiQECbiebD5F+v+vDMTy8r5muINP/A3YiLcK4AtWyJXjhjU5jLlK3+3PFB6JcIZSDhR9eH1JJGdqJ11UU+Pa8c9sYyU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2485;7:PXGsnDkpsSEgFRn3xYrBeiv1TPuAa6UW7vzosG8tBhnJWCS82aVzX97cF4zEfXetSapHqwL/lwGWduwvdmL5vVuj3Z6rjgQrRmNQAaLzvWCI0t9mWQWuCk9R6m/VrQcrhGywXffO6ZIMnuYi49oYMrCLgyEDGQ94cbEwiWEiGSpJSGtzrt5MG4PFf7CFVc1YpF3UcSCc4SyDhRLgACrVI53VATH+ksFa6hEQjB+0VlvRxwQqnnRxJ7Sm1+mHI2gd
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 15:59:00.3061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f9b57f-340d-45c9-1bb8-08d59efbf99b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2485
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596371266008141789?=
X-GMAIL-MSGID: =?utf-8?q?1597375454758406576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The AD5694/AD5694R/AD5695R/AD5696/AD5696R are a family of 4 channel DACs
with 12-bit, 14-bit and 16-bit precision respectively. The devices have
either no built-in reference, or built-in 2.5V reference.

The AD5671R/AD5675R are similar, except that they have 8 instead of 4
channels.

These devices are similar to AD5672R/AD5676/AD5676R and
AD5684/AD5684R/AD5684/AD5685R/AD5686/AD5686R, except that they use i2c
instead of spi.

Datasheets:
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5671R_5675R.pdf
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5696R_5695R_5694R.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- Refactored the patch

 MAINTAINERS                  |  1 +
 drivers/iio/dac/Kconfig      | 10 +++++
 drivers/iio/dac/Makefile     |  1 +
 drivers/iio/dac/ad5686.c     | 28 +++++++++++++
 drivers/iio/dac/ad5686.h     |  7 ++++
 drivers/iio/dac/ad5696-i2c.c | 98 ++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 145 insertions(+)
 create mode 100644 drivers/iio/dac/ad5696-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 637e62d..002cb01 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -797,6 +797,7 @@ L:	linux-pm@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/dac/ad5686*
+F:	drivers/iio/dac/ad5696*
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index a00fc45..dab0b8a 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -145,6 +145,16 @@ config AD5686_SPI
 	To compile this driver as a module, choose M here: the
 	module will be called ad5686.
 
+config AD5696_I2C
+	tristate "Analog Devices AD5696 and similar multi-channel DACs (I2C)"
+	depends on I2C
+	select AD5686
+	help
+	Say yes here to build support for Analog Devices AD5671R, AD5675R,
+	AD5694, AD5694R, AD5695R, AD5696, AD5696R Voltage Output Digital to
+	Analog Converter.
+	To compile this driver as a module, choose M here: the module will be
+	called ad5696.
 
 config AD5755
 	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 07db92e..4397e21 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
+obj-$(CONFIG_AD5696_I2C) += ad5696-i2c.o
 obj-$(CONFIG_AD7303) += ad7303.o
 obj-$(CONFIG_AD8801) += ad8801.o
 obj-$(CONFIG_CIO_DAC) += cio-dac.o
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 95de8b8..596e1c9 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -203,11 +203,21 @@ DECLARE_AD5686_CHANNELS(ad5685r_channels, 14, 2);
 DECLARE_AD5686_CHANNELS(ad5686_channels, 16, 0);
 
 static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
+	[ID_AD5671R] = {
+		.channels = ad5672_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
 	[ID_AD5672R] = {
 		.channels = ad5672_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 8,
 	},
+	[ID_AD5675R] = {
+		.channels = ad5676_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 8,
+	},
 	[ID_AD5676] = {
 		.channels = ad5676_channels,
 		.num_channels = 8,
@@ -240,6 +250,24 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.int_vref_mv = 2500,
 		.num_channels = 4,
 	},
+	[ID_AD5694] = {
+		.channels = ad5684_channels,
+		.num_channels = 4,
+	},
+	[ID_AD5694R] = {
+		.channels = ad5684_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 4,
+	},
+	[ID_AD5696] = {
+		.channels = ad5686_channels,
+		.num_channels = 4,
+	},
+	[ID_AD5696R] = {
+		.channels = ad5686_channels,
+		.int_vref_mv = 2500,
+		.num_channels = 4,
+	},
 };
 
 int ad5686_probe(struct device *dev,
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index e6423af..b2b0110 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -32,7 +32,9 @@
  * ad5686_supported_device_ids:
  */
 enum ad5686_supported_device_ids {
+	ID_AD5671R,
 	ID_AD5672R,
+	ID_AD5675R,
 	ID_AD5676,
 	ID_AD5676R,
 	ID_AD5684,
@@ -40,6 +42,11 @@ enum ad5686_supported_device_ids {
 	ID_AD5685R,
 	ID_AD5686,
 	ID_AD5686R,
+	ID_AD5694,
+	ID_AD5694R,
+	ID_AD5695R,
+	ID_AD5696,
+	ID_AD5696R,
 };
 
 struct ad5686_state;
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
new file mode 100644
index 0000000..c9187de
--- /dev/null
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -0,0 +1,98 @@
+/*
+ * AD5671R, AD5675R, AD5694, AD5694R, AD5695R, AD5696, AD5696R
+ * Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include "ad5686.h"
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
+{
+	struct i2c_client *i2c = to_i2c_client(st->dev);
+	struct i2c_msg msg[2] = {
+		{
+			.addr = i2c->addr,
+			.flags = i2c->flags,
+			.len = 3,
+			.buf = &st->data[0].d8[1],
+		},
+		{
+			.addr = i2c->addr,
+			.flags = i2c->flags | I2C_M_RD,
+			.len = 2,
+			.buf = (char *)&st->data[0].d16,
+		},
+	};
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP) |
+				      AD5686_ADDR(addr) |
+				      0x00);
+
+	ret = i2c_transfer(i2c->adapter, msg, 2);
+	if (ret < 0)
+		return ret;
+
+	return be16_to_cpu(st->data[0].d16);
+}
+
+static int ad5686_i2c_write(struct ad5686_state *st,
+			    u8 cmd, u8 addr, u16 val)
+{
+	struct i2c_client *i2c = to_i2c_client(st->dev);
+	int ret;
+
+	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr)
+				      | val);
+
+	ret = i2c_master_send(i2c, &st->data[0].d8[1], 3);
+	if (ret < 0)
+		return ret;
+
+	return (ret != 3) ? -EIO : 0;
+}
+
+static int ad5686_i2c_probe(struct i2c_client *i2c,
+			    const struct i2c_device_id *id)
+{
+	return ad5686_probe(&i2c->dev, id->driver_data, id->name,
+			    ad5686_i2c_write, ad5686_i2c_read);
+}
+
+static int ad5686_i2c_remove(struct i2c_client *i2c)
+{
+	return ad5686_remove(&i2c->dev);
+}
+
+static const struct i2c_device_id ad5686_i2c_id[] = {
+	{"ad5671r", ID_AD5671R},
+	{"ad5675r", ID_AD5675R},
+	{"ad5694", ID_AD5694},
+	{"ad5694r", ID_AD5694R},
+	{"ad5695r", ID_AD5695R},
+	{"ad5696", ID_AD5696},
+	{"ad5696r", ID_AD5696R},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, i2c_device_id);
+
+static struct i2c_driver ad5686_i2c_driver = {
+	.driver = {
+		.name = "ad5696",
+	},
+	.probe = ad5686_i2c_probe,
+	.remove = ad5686_i2c_remove,
+	.id_table = ad5686_i2c_id,
+};
+
+module_i2c_driver(ad5686_i2c_driver);
+
+MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5686 and similar multi-channel DACs");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
