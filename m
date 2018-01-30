Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeA3VlV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:41:21 -0500
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:15680
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751755AbeA3VlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:41:16 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
From: Andrew Cooks <andrew.cooks@opengear.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC),
        linux-kernel@vger.kernel.org (open list)
Cc: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 3/3] i2c: piix4: add ACPI support
Date: Wed, 31 Jan 2018 07:40:30 +1000
Message-Id: <d197d95d77afa2054ff1b2c593dae7939030e24b.1517285239.git.andrew.cooks@opengear.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517285239.git.andrew.cooks@opengear.com>
References: <cover.1517285239.git.andrew.cooks@opengear.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME1PR01CA0134.ausprd01.prod.outlook.com (10.171.9.147) To
 BLUPR15MB0018.namprd15.prod.outlook.com (10.161.124.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 133af4d1-e701-4f0f-91c6-08d5682a2fe7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BLUPR15MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;3:M5P3ke0dn7k7SmfdSRzsPNM5NT4z9u+6XWveIDZTNslKJW+bLZ+tPuNXi/yyj0UcCmrDpitv8cBPca9sWbzMW5zB/LEogMKl8ePB5qbfALjQPsd4oGKZ9/N4E8oNefZf5jDsmczgnU2rv46rQ8c2DP7KhxeFerhAuOvyX6f/bob6oQAijF07VqEI0ox0CFzTH3cwlaFEh67nhqisR0nO2qSo1VISmgdxtcFfB8op9gtFA2Lj6d0wj8gPinQFNpq4;25:qqSF0VILeIdRWzZRnghAms/SLUmtwriS7Wyv4ovcM8RtV8rKY+N78HmB/9KglHhZtsxoDiZWkBflER+uQ421/LmuzTzefvMTnMcR0vnl1Qxc8JdfdqHd5GVsYq8Ks3KXCZ1arFlRqyVPz1dddeLvNGq8tDFqbwfS+z2kS0JBXH3WQeOPAswbxOG0wzUB2EwG2n4JDkwUSYZ/G7MpZp2fZFR8KYZRTCZBoRUim8fHb1uGcQRnxIyhw7clg5hZVATVmczGIU50CslHyzl7elorXEaw3wKJ5W/vN3BiJo4YhINxErr0CpDvnn7Ev97XaCotYUY7IEOZbLITCTeu3qHIAQ==;31:Q08xsP3e6QDWAwyiMVAcV0TE5UQnXofiido/JiGa4fECvN0zpQV8F5oBQ3jZx4D+YJsugl62uHL1Aqr3Pent2R7dIS+cr/e0luNMKQGcjwSIdakx61HpvVD8s9rLON+4Lw37mVBWd0sExLXfZMP12pB4vzPW423hsSYO4jryTFla2iv0urXWHyCgUZyu8UnB0YY3dkJDcw30czd6kD86l7/coeMq3Ka6CQy0KMKNoRA=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0018:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;20:741kyVfkfCWuxycouaNoTHwravUGaq2Crl+XzPhKYGPvyzBNJ8XoEaS6IdEfaATEoGE2ZDvct2ogzWuwhlKJrM2D1IhV7jrf3mgIxdlenVBYQ6SKvG4if56ZlNVTAu96CenMZYw62hzgEmBQFxfKlj0bImDscyhdkEUy+I9iqX0=;4:TkxDNPYooQoRS7HrOp2cteOASNCGEjSJaHXHRM0WILd5h5Ry65pFt+ztbyzPYEBWYnj1Pk5+qEo1IG6y1iZpOzl0YoDVJsUURWQZF2xX8Rcccgghct+4eIFuMgkXxLQvBS9c2M13ubrzfL3X/1MZz3bRCVMrlFuvWmyMB+17Ahs1ivW1yTuGIgkWC1ydCePBbI953HlUAqGUY7DUuVJIGqQ6ryJH1zuZvGiNAg3xRRhPgOkDBbVNTBst3cNAuMZeN4nOqbqPHaalpsxzcezUDWFvieV0mtp0wD44hSNayB2QmAOZynY4Ev8QiUHC6lHr
X-Microsoft-Antispam-PRVS: <BLUPR15MB0018E68531D5870B8CD86331EEE40@BLUPR15MB0018.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR15MB0018;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0018;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39840400004)(376002)(396003)(346002)(189003)(199004)(76176011)(50466002)(107886003)(97736004)(48376002)(2906002)(16526019)(8936002)(81156014)(8676002)(47776003)(3846002)(86362001)(316002)(50226002)(16586007)(81166006)(53936002)(66066001)(110136005)(118296001)(105586002)(6116002)(186003)(26005)(36756003)(68736007)(7736002)(4326008)(106356001)(305945005)(6666003)(6486002)(2950100002)(386003)(25786009)(5660300001)(59450400001)(51416003)(52116002)(7696005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR15MB0018;H:andrewc.bne.opengear.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0018;23:OowLJumkhAnYfSqw1+j6irm33BOjycLYwHRE0UIay?=
 =?us-ascii?Q?i83cCC96CGbFSgQoYI21c+fToFINtrViG7M41VICDDTknYt+W6RH229kbWX4?=
 =?us-ascii?Q?5tqvmr0gFzWrK+pn0rBohKCCEpAb0oCyPY/ZfC00Mr4PT+ArHR4hzDY+uZ7M?=
 =?us-ascii?Q?khoIxS00a1pHLR482aS/3FunQFxV/rqbOVf+LhewEE8QcTqftGy411NDwQbu?=
 =?us-ascii?Q?ojAKSzO4ujE7yWhzIeBsDyRefDovWuXFcmLocOdl5jEgMtsMHDSyHtdO+Vx2?=
 =?us-ascii?Q?VYS4Q1YCwUvEqLRTYuzDdsOYbOW3E4jttPwPZoAmP9vQr67weFkiTDxOXw1t?=
 =?us-ascii?Q?hRLxhxwgnB/V0jx2A1U4ip5+T4dBWj3LJYYOQP7OAjMsWQNNu+w7QdfXQkGa?=
 =?us-ascii?Q?q/aRmN6VTeN/cMwbg42qHXQB+x65VElo+wYEq2ks0H1Ar9DYJPzmLGulOxwo?=
 =?us-ascii?Q?p1o8pAay+UZVX+eHjXd3xZ3dEp4gvtUPV3cW47eTDEUWqfHCwH+RxphWRMMJ?=
 =?us-ascii?Q?YtQGVJQ/vdUMT/CJEQf5gYdkZn5hwB1YiB6lbSbyK/RdqSrOKAesozMzdwtT?=
 =?us-ascii?Q?hGnrtYAFW9fRJBVGa7VPTOY8NTIzxUstIchgNk6rJYWycAMmjLbeGksqj8ly?=
 =?us-ascii?Q?WbCTNkC4qkwb9NDRIFR46Y6Sqv3pzbHc4CvYxeOtMbRkijYHZ0ifW1PLT2hp?=
 =?us-ascii?Q?zUx42VJi01+ETjzVZ++G2E2YSw4tH5hsMrrlzxTKJw87zVaiDflgngJuD4uh?=
 =?us-ascii?Q?2LjnxeP/Hpvi5Xh3Q3bTs2B/+CL6J3qHAEYec3WTXSbQZ2H0h98sYk4VFWIj?=
 =?us-ascii?Q?wqpXlscM/7sKjM1h3TlAmmAkW8p1wfC9nBulx0NzWmaRlS5YAXcmL9piudpb?=
 =?us-ascii?Q?phIdddL+l0k5u+lr/zzF2VIXKB9hh92LqSVP2pyEocR9TI9q7jLtAFhj5Nvn?=
 =?us-ascii?Q?M06vkz6NqzA92vFPgVMZ6vet/xdn1fHvCx3Uxgy1bHPIrzzbXRdQ87wTZOxN?=
 =?us-ascii?Q?h5F6PS9IUqpE2g1GOo6Vr+L0Diz1hnzrhy3mbE+ef62JZmDWBh7fAINQB/Ag?=
 =?us-ascii?Q?OcX0ewH1hVp147Mbkp5RqquCdHG5yyHvixHCjYXDjwY9r8acWONx1qgYMVxL?=
 =?us-ascii?Q?4GI/ezAAOVpZyaaTSD7tMCD9MkRoP/m1wxkvRvXGY1Gmzs5Ol7h9Q=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;6:VIzEMfKQSr837srZtgozmqzzZUzuggjWm6dyxqWusgVCXa5ckHXGFyBHTAgs3CR9PVXbcATlZsHjIf3qCF2kWmG+0at57lS2zXzjShfERFDHowwwbaNylZN6YDlmM7hFfW+W04FMIPWSmJd4i++DtrcmFBa72A75wd2a+Vo1XInYYTe+09wVt1zWPZf6BQXzCFNn4GClK5QhHI/wiYDmcr+9nlhWmrIDiBT1CWktfzatgG1koHm4tpedil4rySWLRtZZ+TouP09sBFKfslkYQbP88DCz1eDO7eqRnZLx14rSx6AfQAeQ69etNe4TWYQRHbfqHlZ7UhgQjwVNySoJgwa17hhIb2ipMb/xLNJmUKA=;5:QDdsfl5+r0xnC/E2vNiQRhbJ9dQCtamD6mmarCGCuuyztp8Dlh7U0cYMBeLZoWUBSS2D1xgX/akrilSS295OlCWqfODDKn4+iszc7U9K/mm1CzHCyEZEd3Jr123qeA/RtRfjDkGBz08dIjOpVtMGP5etnKAR0n4rsLEPqeJXxRU=;24:NhU1pyMFc0SJvpihRE63mIr/I9PN7lemyyCk1LraTxssePYOicEafZimsfwJqZeu64CaGDkenhZesHPy629fpqFc/MBcCa8E9pRFpZwdFPk=;7:ZW/fx+hBBwu6gvgjDN02gRF6RHuYadfwrwi1Ms3+NlyQVevZzkhJMtb6uJHrJW6coE+aJFF9uaEi0DfVkac7aWccIRNU0mNo1RvhGF1a7UbBvuDTr6BTisn9dMTWukef+iyl1bThoQ8WGJfRSKObTjNmdPjRQIQnJEcrllgZFLUlFc6Y9R/AGQCVvv+JKbrgMxxublLdpY06KH0tGz5RUv6SMYYd8XbUmxHTKCTz9+Sj9r2t7j6QJSMe0k89k2Th
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 21:41:12.7694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 133af4d1-e701-4f0f-91c6-08d5682a2fe7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the i2c-piix4 SMBus controller driver to enumerate I2C slave
devices using ACPI. It builds on the related I2C mux device work
in commit 8eb5c87a92c0 ("i2c: add ACPI support for I2C mux ports")

In the i2c-piix4 driver the adapters are enumerated as:
 Main SMBus adapter Port 0, Port 2, ..., aux port (i.e., ASF adapter)

However, in the AMD BKDG documentation[1], the implied order of ports is:
 Main SMBus adapter Port 0, ASF adapter, Port 2, Port 3, ...

This ordering difference is unfortunate, and we assume that ACPI
developers will use the Linux ordering, as follows:

Device(SBUS) {
        Name(_ADR, 0x00140000)
        Name(_HID, "SMB0001")

        Device(CH00) {
                Name(_ADR, 0) // main SMBus adapter, Port 0
                Name (_STR, Unicode ("Main SMBus adapter, Port 0"))
        }

        Device(CH01) {
                Name(_ADR, 1) // main SMBus Port 2 (Port 1 label is undefined)
                Name (_STR, Unicode ("Main SMBus adapter, Port 2"))
        }

        Device (CH02) {
                Name(_ADR, 2) // ASF adapter (what Linux calls 'aux port')
                Name (_STR, Unicode ("AUX / ASF SMBus adapter"))
        }
}

[1] 52740 BIOS and Kernel Developer's Guide (BKDG) for AMD Family 16h
Models 30h-3Fh Processors

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/i2c/busses/i2c-piix4.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 01f1610..9a6cdc8 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -837,6 +837,12 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	/* set up the sysfs linkage to our parent device */
 	adap->dev.parent = &dev->dev;
 
+	if (has_acpi_companion(&dev->dev)) {
+		acpi_preset_companion(&adap->dev,
+				ACPI_COMPANION(&dev->dev),
+				piix4_adapter_count);
+	}
+
 	snprintf(adap->name, sizeof(adap->name),
 		"SMBus PIIX4 adapter%s at %04x", name, smba);
 
-- 
2.7.4
