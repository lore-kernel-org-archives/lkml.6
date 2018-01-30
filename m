Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeA3VmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:42:10 -0500
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:18784
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752277AbeA3VlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:41:13 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
From: Andrew Cooks <andrew.cooks@opengear.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC),
        linux-kernel@vger.kernel.org (open list)
Cc: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 2/3] i2c: piix4: fix probing of reserved ports on AMD
Date: Wed, 31 Jan 2018 07:40:29 +1000
Message-Id: <970f151329b43cfa5f842dc0fe0604b03c5c1297.1517285239.git.andrew.cooks@opengear.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517285239.git.andrew.cooks@opengear.com>
References: <cover.1517285239.git.andrew.cooks@opengear.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME1PR01CA0134.ausprd01.prod.outlook.com (10.171.9.147) To
 BLUPR15MB0018.namprd15.prod.outlook.com (10.161.124.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8950f6cf-1c3a-4e7a-2c5b-08d5682a2e7d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BLUPR15MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;3:DTdQWvqk9Biipag7TwF8aEP0h8Am4u3nvEvokCMyKRJZqc91M7YdiZ2HxfA3k21I2w8ckThEvnMGG5pN491sYoHTURQvIE+CREoKgJOxldxNPmXhowHpux/6nLdb2zGXU7Xf6C5yT9T1oFE2iMX+eUYmnGkw8ULZzy+ph7Pp5LJMXQEvgmXXHtrqOMqCUUD2HWLGYJNvfQjnRYCWut9P8o5u3GQQobXa2hUDuFDJsf83AEKlE8pOmslYLACQkp34;25:UXL+XIwP7eg8s2V7/4VIOEbn4n52dok5hN1Rs16/t6oHYh4YkV7cECqLDO8xoXEXU94yTt8DrmaQjyKMcLzA1VCPkVK8DIKoBrlVVl20FhJqtUuiwxSy9wyhlZZZclOpS347iyyB6APfKub7vUEAodxuh6mPBbffpngCx/8gjuHPuIzrOkvE+aKeyZtQANzFS40gsHqfXzW+CS+UuLpqnEFC2fI9jUaS7jcOy8L+GKuz/e4+8XbDtW57dvR2a6pdRJ1ACaS2hqGLPWT/EZ9tTooQXQ3A0Po2dVyVrVFeFz/r2WjgiA3ecTZJukf3MqDv8I/NsNzyGuuy9o1TaMtPMw==;31:ZRzRmIpt3Em3Ce3ftqsgD4nJ73x5UaLBUF3gbcf809HbYIWA6HKl9VXm0OwG4GDrGf2I77cJ2yg0n14R4rEBFAkivq3jYBxD+B9Th3HmUDNhdNTshD02OzLQiNMJOevJgoilhCCtYV8kjN2oGfEooz4rGObmR14byKH37ry0WGo3ZbVPCOJ1TzBGdGhcK6sNHnnJT1Ste5YMB6d/7VfscS3mDG7djGLCki/64Av2w0E=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0018:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;20:ZVGb2lxTbNUBlbgOfAyGwcLd7pHV5YIBv3wfRNFe6HQSmpot0WUbanU82xlJN5OgR6InD//flHewGGc99UnAbJywmgeW23FCQLLnyjx1jsCc3zX80enAWG0bYgUCnM60bAeT/Zlz+DLIUkCXKqmjxk1Aj2NDfonahq+AjethI/w=;4:NlvEdb6jC252jeq2gWwPyMWI0QYSmYTVUYAfLLbLdKxNQioC1K9kgdKXwzRt86uj2VT3iTqY8CTIEvUZa7RjDuDLuRXiWObMBLQARW8wOKLT2w8g4dRIScm7iXe5q81jt0B4IEiKvdfjF0Dft8J5gx37563VnNFHS1XqfxVtpb7biPsq4fLPUVmHXCAi0wdZ+l72EgAEeaNfLv+Iga0/MQhif2Rp5luWJAEFwdXPZhF3m/BMuB241LYypky3eU8lDEkhaCidjYA5MFYposc6kg==
X-Microsoft-Antispam-PRVS: <BLUPR15MB00185B9CF024A6D06D933CFBEEE40@BLUPR15MB0018.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR15MB0018;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0018;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39840400004)(376002)(396003)(346002)(189003)(199004)(76176011)(50466002)(107886003)(97736004)(48376002)(2906002)(16526019)(8936002)(81156014)(8676002)(47776003)(3846002)(86362001)(316002)(50226002)(16586007)(81166006)(53936002)(66066001)(110136005)(118296001)(105586002)(6116002)(186003)(26005)(36756003)(68736007)(7736002)(4326008)(106356001)(305945005)(6666003)(6486002)(2950100002)(386003)(25786009)(5660300001)(51416003)(52116002)(7696005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR15MB0018;H:andrewc.bne.opengear.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0018;23:tfbkYKKjA7kS0i/Dzb7ZF+YuDJ2jOQRp07hhmWU+6?=
 =?us-ascii?Q?w5MkHiyXYFvxSH2PEFrJ36lYxjfulXm98p/O2UIA0LwmBEGhqRZw+JmsxWRy?=
 =?us-ascii?Q?U1r3SlveWyWS9hSJW/LdMaVXq54WQk3j2OMfEA9o/Y3i02Unl/zWQWM14rfj?=
 =?us-ascii?Q?EEfEo5ZxgdE1c3IXZ4a/JvuOK/iR9/zoaOEtqq3p0N4xzDBd+/v/+OZoNOSR?=
 =?us-ascii?Q?SSjuICvwqtZb/mU9lcbVhAw+20t2txrM6rexZX6sXsz0WhqmO6aBKTN8qvO8?=
 =?us-ascii?Q?zAmO1Y5iBgiGu7uu0KCh/lL8srfjKbNQa8Rk3a7w/h2SG4tk3Ob5301/eSKK?=
 =?us-ascii?Q?qcQm5GZN5mgYam3cAFzMTLksubyPBhEwC7yJhhBvoaRpagfTQ7c1D3n42tEu?=
 =?us-ascii?Q?6NfQoqK0a8i6yyzx2p5GBS9xi1V+OCNZqxlOBN/sBO4lmrx533r0AaDljK9y?=
 =?us-ascii?Q?UdPfrgeYiQdlCOyXvJ+1ra5o6rVn7ty7vq2+FA+F94eBjdJTDSg0EK/YtEwb?=
 =?us-ascii?Q?YZ2zs6aVHBN/qVwDvNCnK3SIfW+dWH5JIogYIWAHlqETztUCScuIQIPyINZS?=
 =?us-ascii?Q?lLKHBDda3l0JxfiT/OsesajApK+JiW/4oGhKDG/OrLqEEyVqQQqNG1fRmvno?=
 =?us-ascii?Q?jiPq+LEHS+Ofs2CIZs981pgAQGEI07UDn3PNJeBTl7/bevYVCkaP2fmikEXA?=
 =?us-ascii?Q?cWyqBCRQysrhab/0WrL29l8WD7eQXZv0Qm7SkNvPqPMhIjEMnQpFM6USEN68?=
 =?us-ascii?Q?KbgeNVHSh6wHS5F32syaRN5Hl8WfbN5/7zVsFtS8NQdAp1uJF8b9AfHow6gm?=
 =?us-ascii?Q?CCS3qcNsL27QWGaJCZyyWSJOFln1H1UV8xbMlVMMuFl2j3NmsfW44Xt6BfNs?=
 =?us-ascii?Q?Tia8soPFY+Xwtlhmc4eaVbmV+y/0L9m+kjrG4PzXzcV2UGWsZxV2lWbimfGU?=
 =?us-ascii?Q?tTonmFs1b1L6qX3I6uySO3Dz8R3bclH+am5FnyWecWsk92oTa4t7o23PBjJl?=
 =?us-ascii?Q?Y4tUHKYnhUalg8o3Iup2mnwVvC7YubqMmAUHHTz0y7+tiWs7zgSs4P4TAENW?=
 =?us-ascii?Q?uDYtAYhD0K/Vq1R0KL//LAVIPZVH3B2W18kEPPd2+ABlprOC74Aju+VFnDzw?=
 =?us-ascii?Q?jfGvivLuzw=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;6:5kpFKvcO5+Qkpbwd1KDKXdqtNH3q2XVds85rgJ3XeLBtpA81u1HWJO/uGVvbNfTbNN2OdIM3kH5tbBIV6oxFccSqAAvZ1zembC5KH818ceLCWZ2MRbD7ZUgmcabpVGolDfq5TrAB4a6IVYExeyJWJM0QIiohXT90+gULCmoRu5T4XReIU58RGC+hcyhqVcsrtA5tid/LURqu6Hvm4RSP858NY9DU+HIflnFovs37UndnDoONQhxogATzzxDF32NJsSACOcfNENmwnv/4YReBGQjewWr/hSQIXRHz6eRYEsx9ShbbJ/mOo5vlGOqYtTbXm7WatWhtGpnc4/6/ehuZ6BCtogUKMHnzNjpz7RI/XlE=;5:1X29MLzZ4a0V49FUTdvUuKCkC31QHqPZAih5S4PMBx442zh2zJ6zSw8zO8CxV8qW1LW4OR2kD3XdeGDUQzrsaKRiHmHMVvQZfuQsZa8v3J4tUhZ7Pe94zbp955fjjGoDHSmSrdV8bwb9y0SV9iZKxRLvqpyJwHEcyff0gvGUM38=;24:rOIt0t+urlKs/mOpCDyiQ3CNGmxxHTgLGJLDJKVZyF6Q27BzBjhy9I+72yZZuHrsaczzNnggEgcV7zCqHheXAV7RFy7T2Tc289Xzoe0QB2I=;7:Ecs0UbQ4G1AOVfPkGbDL96KOzO0T466LUq7ifQPxg8oO0gQGaQdQfcZmhQLsrCnBX1iffBu1woIlzkVJechEo+MzVyhpK1wQffgLQr0i7X/LaEgKIKgy4eKA70lFT/fRnlUnAEVTGKCwnZRQg7vTY6eoRJXl56q06bAwBiNKxEskTc7ofdDCxFYnSQKsuYAN24N3wUbkXCIMzZAc6wtgrnv7RQ+ty82gEmWZcuWObdZbq3qBRcvFAF/B1Nr4zQ3c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 21:41:10.2538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8950f6cf-1c3a-4e7a-2c5b-08d5682a2e7d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent bus timeouts and resets on Family 16h Model 30h), by not
probing reserved Ports 3 and 4.

According to the AMD BIOS and Kernel Developer's Guides (BKDG), Port 3
and Port 4 are reserved on the following devices:
 - Family 15h Model 60h-6Fh,
 - Family 15h Model 70h-7Fh,
 - Family 16h Model 30h-3Fh,

Signed-off-by: Andrew Cooks <andrew.cooks@opengear.com>
---
 drivers/i2c/busses/i2c-piix4.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 5c90a44..01f1610 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -80,7 +80,8 @@
 #define PIIX4_BLOCK_DATA	0x14
 
 /* Multi-port constants */
-#define PIIX4_MAX_ADAPTERS 4
+#define PIIX4_MAX_ADAPTERS	4
+#define HUDSON2_MAIN_PORTS	2 /* HUDSON2, KERNCZ reserves ports 3, 4 */
 
 /* SB800 constants */
 #define SB800_PIIX4_SMB_IDX		0xcd6
@@ -800,6 +801,7 @@ MODULE_DEVICE_TABLE (pci, piix4_ids);
 
 static struct i2c_adapter *piix4_main_adapters[PIIX4_MAX_ADAPTERS];
 static struct i2c_adapter *piix4_aux_adapter;
+static int piix4_adapter_count;
 
 static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 			     bool sb800_main, u8 port, bool notify_imc,
@@ -849,6 +851,7 @@ static int piix4_add_adapter(struct pci_dev *dev, unsigned short smba,
 	}
 
 	*padap = adap;
+	piix4_adapter_count++;
 	return 0;
 }
 
@@ -856,10 +859,17 @@ static int piix4_add_adapters_sb800(struct pci_dev *dev, unsigned short smba,
 				    bool notify_imc)
 {
 	struct i2c_piix4_adapdata *adapdata;
-	int port;
+	int port, port_count;
 	int retval;
 
-	for (port = 0; port < PIIX4_MAX_ADAPTERS; port++) {
+	if (dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS ||
+	    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
+		port_count = HUDSON2_MAIN_PORTS;
+	} else {
+		port_count = PIIX4_MAX_ADAPTERS;
+	}
+
+	for (port = 0; port < port_count; port++) {
 		retval = piix4_add_adapter(dev, smba, true, port, notify_imc,
 					   piix4_main_port_names_sb800[port],
 					   &piix4_main_adapters[port]);
@@ -889,6 +899,7 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	int retval;
 	bool is_sb800 = false;
+	piix4_adapter_count = 0;
 
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
@@ -993,7 +1004,7 @@ static void piix4_adap_remove(struct i2c_adapter *adap)
 
 static void piix4_remove(struct pci_dev *dev)
 {
-	int port = PIIX4_MAX_ADAPTERS;
+	int port = piix4_adapter_count;
 
 	while (--port >= 0) {
 		if (piix4_main_adapters[port]) {
-- 
2.7.4
