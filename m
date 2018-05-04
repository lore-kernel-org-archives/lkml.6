Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeEDRJl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:09:41 -0400
Received: from mail-sn1nam02on0071.outbound.protection.outlook.com ([104.47.36.71]:47186
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeEDRJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:09:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/2] ACPI: APD: Add AMD misc clock handler support
Date: Sat,  5 May 2018 01:07:19 +0800
Message-Id: <1525453639-30575-3-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
References: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::18) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:ZqmKogJJvB39RpEsCyLIW5lcjdGbYmxL2zojX4/zTOPvkzJn7HtH8ZjN2i1XUmLLYrp5x20CV9oydeBVvYPwEqgkzHodNg3riNPMhG35uC8eauy4HWW/P4L/A87ZmRplCAkdO80QSoCMcT8EP/iWPaSfNp/TBB7mpXLyt+cW0iPNqxNrZgNdr+EEBWFepws3zZ6IRbkflqTrkdFs4chiBh7iSiBo92oET+H8tNBq0NAcL6Y2/IwKPIZUCcKfmIro;25:edHhf3tBo/mDHqj0C6X4vgpXESR4kF+Xe6xUV7Aq78MugpdkTvEKdcvLA4hFXCyxNLlgKDQA6pYV4/t0ot8nuB8WUWfVxPgLuVzR3GL2fn1AzLN0IlWeWzLStDryHdQS3/2OeCA5qZn88LPaok1DLrPS2FmXhrb68EOAxMTltaQbEqNSbI2xlfJv5UjBpHn0T7Y7gpoBz5AVFZGquh7CeX63mBEbivKEBolaV7++u2Dfk/ZzGqZABG5PPUOGgXXXWu4LvIK8bcjR2dORz2zCtWgMlR3dmOMF8TMjzV/xbfqiWG98c0QinTItCKgrBszFe8P7MMDF3dORKBWnl8xRNw==;31:1tuvxOs4C9uIiGB6oG5P+yDkijBbXAUTns3fOsSIiqXqqMnLMyGJpBtQOwKMb56IwHKdml6y8xzOT54alYnpNm+RnUMv4qgkosRGMNc5xHnofNiXdk7BnXOq7qQ4Di0LIuGYrdqeU124FsisJYON9zVpEZxH0V41KYla60yaY4Jf0ipjlHcbgzz/aeprlYO0VBAjBjIs00/MvvBCLhz1M/++ACVVoIb75dPlLmhj4mw=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:/h7sXY3V2mbyIVd4Xy6qGHZmlOxbkqGdMOI0O/CmohSpcX6iudJYG09olJaZ8to7h+hFGtAjhgcaYmXqLYbDPu+U4enK7SOA73vGjCixrQY5JHWrGrlew18ynCds6dMyVWyLBCjcvTOLhQCMwXafYAX+hqoBGBuOOfjaZABI4sqnxq0wYOgcoY1Cxv1J1knqS87KjMViS273BbJv0nVhpe6yGfgpCNCZ2B0lAE9S2tmF24teDEMYujyEp4hCHz+1A8lfgJfYwQ9ioKrHj7Ax+MbI8k6bXpBpVY+nyg8FWNz80pufODdig8dTreM+zXQFPmr15zjj76waNHXlMPIYf2TIYFjLJ0Zx5rgTY7SWgrc1IBaf0JavBZG5g+ULsu81jZjBo3WMXigBPdVMDg7/ixoewGz4Ey75AdzrfOWp6FyRtLu1TWQg7tQvj6Wh70CWmHeNwAxdIYb7idEnOaHSJKUIgG8CBjL9770cZsj3SMMM1jhg71gPUswogbB/1H1f;4:151Jz4pNcQCCCvnnkGuGl/uho1udKYZ2JPjYRstazWQEeAwCeREHr7T7E59oA2x5aeLTYt1MEIlNI5P24eIEjV9c4UTNNosmsL49Y8J1G1s2zsdG5zWyLj765vddrpiMNcgJwmv8fzho5EqUNusmS1UxH+16xZ8XzkcxsYxjfsRvNR1GkGnVVBcDDualoyS+YwPGxkVhmDB/RP2q91gR3rsTYo2wqa/Reh6ltx9kqS48Pfuvt+PoYJpJe8G7rbRbI7FnnRubc/Kkd+p68L1veiqxCPCCtw6q6YE5xCvEEZnj52Bd1qEEakDUIo0ojQg+vMo6nd91IuwhiZd7/Y4FFw==
X-Microsoft-Antispam-PRVS: <SN1PR12MB236629C472E876BB2BED6FAEF8860@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(39380400002)(199004)(189003)(26005)(11346002)(5660300001)(2906002)(50466002)(52116002)(186003)(1671002)(106356001)(68736007)(51416003)(36756003)(7696005)(105586002)(4326008)(76176011)(8936002)(48376002)(50226002)(97736004)(3846002)(44832011)(386003)(109986005)(6116002)(478600001)(72206003)(7736002)(305945005)(486006)(53416004)(16526019)(81166006)(575784001)(16586007)(25786009)(8676002)(6486002)(86362001)(476003)(956004)(81156014)(316002)(53936002)(66066001)(47776003)(2616005)(6666003)(59450400001)(446003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:VGgfEyPHDqaMVZxU6xOGrQm9eyYXjr85LijKErAH5?=
 =?us-ascii?Q?569A5664g/Zu5GsYXxz+ETOxfMEfI9VyM7zkCmSCdXNScPq6LeLy8KTaMAe1?=
 =?us-ascii?Q?+o97fEKI0ab6MF2VHvSCyKYhv9sQ6aOmzi/YlBM3i6PHFi+40bSZHP3l3Mgx?=
 =?us-ascii?Q?oMDekwRRLRY/WG/b4lsw4V4BSEnsxuNHf5KyxqrBz6Gn62/yD6YGXSmaJeay?=
 =?us-ascii?Q?w0NofwAi7gdQFK73pOkOpfEw79P39JM4JA5b6PGqnYmUaD94G04oe4AQPGvc?=
 =?us-ascii?Q?waswEssVCDLzOXXGBjnfDccoBOLkZRA0DEPqzAhMdprNsj09EWthaUzsLqqp?=
 =?us-ascii?Q?AkPXFQThH8r1Vb0f/4fo7SkmykSeN+7FSPbXNHTpFel9LUVlc5/Kfg2BqfQH?=
 =?us-ascii?Q?erjBOEpbA4/1by8u804TgZ3qhjtwpbVia04ZrhYniD7/wkDYWQ6zawn5803+?=
 =?us-ascii?Q?FteRUY2w7FmDU69xpDJbp5hKn10o9aPwW6EnXiPe45AwXn+DpeaDkFcL6S28?=
 =?us-ascii?Q?lGrjnDWAYmGqzrdQOR9UKoy5gy/nbm9cj6J5uEFoCkcFR4UvPv8LHmzjlqFe?=
 =?us-ascii?Q?oWsPsBHvAMOtwWpDITC7J8CSa7kAXAJ6gTJr8MbWPc64ZcC6St945q03GxvP?=
 =?us-ascii?Q?t91mpF6MWdTM7p7wMsHNOFPFKlsU6tLY7McTCxV45huQ4fnkFsum2cUGLNiz?=
 =?us-ascii?Q?MVZOHV30zWLF5QWJoJPIeVPQt1LeAEqL6uQNdW/h7IGliz61s7WcwJdXVd4/?=
 =?us-ascii?Q?9FUGvkOzwI6q7Mbx9Rpx+O/ZKUfaq4ww80ESVy1K72zzHV3OUSpN/rhuFN9T?=
 =?us-ascii?Q?O4IjBIahJAuRlGv9aH4TQFcF51OrAPK3Nt1pqc3s/uFWGipDZoM8whcsGy/h?=
 =?us-ascii?Q?cB0aQV9X5MT5SDVwEypPrqHOCvXIu+0VECNRYiEShomdPhMEuAF7fnpcr0Kp?=
 =?us-ascii?Q?Qc5hWQssPc/lHTi8mw7ripcDsMxqsV/XBmZICkIUXkKpxHIo/IAK/eEWSmqg?=
 =?us-ascii?Q?spzTxSYrLOHQ24eUjnGOO5FvEHQzjlETRnDsw8ZAY6HhMiJnMBbOHt3cj2J+?=
 =?us-ascii?Q?G9Af1yFPVX1y9KCt8vfFN/BG155VexQAaUk/mNpUwQs+8tCrj1SBtzdxK2uh?=
 =?us-ascii?Q?8VW18tvHElNrPzaybEvrQ0+3y8u5Yf2RhdOfMK1yuBjFJKoCttNDRFzjFDtq?=
 =?us-ascii?Q?/ETZCwy7hc+frqjKhPz3RzNalWTPmiT0n4ejb8pwazzAJwx8aUthFxXcWPEa?=
 =?us-ascii?Q?rkg9SSCFsc231XTw7unSFO8uH3D19RkK06g32cV/fxspz0wl7j9SkIqqXW07?=
 =?us-ascii?Q?huy0KB+B+ac/3y72PEzsoI=3D?=
X-Microsoft-Antispam-Message-Info: KQC8XbwyF62s0UMRXOAWdugnBO9Dw1YVogX2GV+osl3n3fxElA4TacoaNU/z+usAxlOcMpI0y9HM5yToea6gzHN3q8WmPLhDtrqOEtNPAyf9URX7RqyYtnp1gZbI70NJsVXvi8z1zrWkn+jwN3qDLLrBMxmGgPIZ2/UJVtfDYuJuVv7Q+b6BLMjgXgiNnPc/
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:JB10cthvY6eTpjo/lbplEu0aiyXO6IH+8BS0bU4Jth5/5WURmLW2bUHTOoaAX8FPT62iXDTmeCzSyymfP3Cf+EvyTWAYHheZCiLvmnOeOm31puB5KpqxygOo7cszk9lP+GxGQPn7mA/ivuoD0Krb4JkuPgLd7PBlaBimYOzdd6cfrWd6iteWNF4wVmkrTJS87mneALrF23IwyQszqWKIUH7OgQNhTZzjcvwW47WPan1orY/N5tWgC6B/4w7XBxb/cSDcS9APuMDFMqoWzQ9jiuykr7G2OqfBQSvsoDIlTqTL50m4VxBJJsG80AdQDq10Fanya8PKj5eeyvg1VCdljCavc5fPUFTEhreMduaTXEjA3WUrSlnMO9syH5XAPYQpAMNoQSs8TM3JvlukL9rBeELzgYyTGdk9hJG8DcJ0W+1ozR8xAe9+UDmXcSTamF8fjkZZxvoeNhjYMJaeD4MLBA==;5:bB0mho5+r1VgISXJVZ53rl+m4zzj6eCe7YEjvBkMdvbognRE1Y346uPAtYyn/e0JZC0vh9s+8F6Ng3k1P7o2bkq45aPok8fkkYFhpZz9ObPBfNfSo5/nssbkdJlVzjX52VDMuLzjn4ud4VMShnT0c36J7XQqMPZLKmcSBzYdHgU=;24:D4VSAAq9YqrEqO75cYFVo0qpmp08yQ1Cq6IR+PRw1qxnnD5qKpZDgA1Qhn/ntBJ+bm54sTNP9RQ3MrvJdmO3lDlQfnkSxZ71laoBxrkXGpQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:5peXr8jDihxVdtA2EYt808YhBkTSHqQgr00+SH/Kdbbd8n77WuxFlrH/ohw/zRec5Q9ylTgmkUHCvjxew5pzPfje+AhxuTEOSAbMEgd6YHSlXcWCErxCmKO2lFZbvqMY5QiFfe4eR4wthR4X64NHZt+ficYEk92p6knXwC9hhwTdIHF75BIDiVUmEmx/p/AnBuwihF1Na9Q63+Io/ESOBszMfKlP4zV1oS1KBNydEgHsWJ8op/RUtrQTaWaP47Py;20:Wb1cs2JdTlqWdoxdqfBk65LEBf3CFNTsjuvcGpxUeW3mpmKsuhmqHPZGD3AT2KWg5Ov1XKOJkPA0mjon1Wmd7VYQdSfhr/G+cCYOB5+vDTA+oiLrHx0y3eV3B1dOquAw0L4kFi7LEt2vYOuMbY88wlpCiJ3VNt8yhLupS7D5kkYRbvBLhzts0AFuBsWzzR/Q2NTNKO+efq658Cx6bIi4PO7LsPnkbq8OGn/nuVet/Mb24Wt2Ns+/l5MQCEuLepc3
X-MS-Office365-Filtering-Correlation-Id: a345445b-26c3-43d9-dc09-08d5b1e1cfa8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 17:09:31.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a345445b-26c3-43d9-dc09-08d5b1e1cfa8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD SoC exposes clock for general purpose use. The clock registration
is done in clk-st driver. The MMIO mapping are passed on to the
clock driver for accessing the registers.
The misc clock handler will create MMIO mappings to access the
clock registers and enable the clock driver to expose the clock
for use of drivers which will connect to it.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
v2: Submitted with dependent patch, removed unneeded kfree for devm_kzalloc
 drivers/acpi/acpi_apd.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index d553b00..88b8a3e 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/platform_data/clk-st.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/clkdev.h>
@@ -72,6 +73,50 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 }
 
 #ifdef CONFIG_X86_AMD_PLATFORM_DEVICE
+
+static int misc_check_res(struct acpi_resource *ares, void *data)
+{
+	struct resource res;
+
+	return !acpi_dev_resource_memory(ares, &res);
+}
+
+static int st_misc_setup(struct apd_private_data *pdata)
+{
+	struct acpi_device *adev = pdata->adev;
+	struct platform_device *clkdev;
+	struct st_clk_data *clk_data;
+	struct resource_entry *rentry;
+	struct list_head resource_list;
+	int ret;
+
+	clk_data = devm_kzalloc(&adev->dev, sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list, misc_check_res,
+				     NULL);
+	if (ret < 0)
+		return -ENOMEM;
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		clk_data->base = ioremap(rentry->res->start,
+					 resource_size(rentry->res));
+		break;
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	clkdev = platform_device_register_data(&adev->dev, "clk-st",
+					       PLATFORM_DEVID_NONE, clk_data,
+					       sizeof(*clk_data));
+	if (IS_ERR(clkdev))
+		return PTR_ERR(clkdev);
+
+	return 0;
+}
+
 static const struct apd_device_desc cz_i2c_desc = {
 	.setup = acpi_apd_setup,
 	.fixed_clk_rate = 133000000,
@@ -94,6 +139,10 @@ static int acpi_apd_setup(struct apd_private_data *pdata)
 	.fixed_clk_rate = 48000000,
 	.properties = uart_properties,
 };
+
+static const struct apd_device_desc st_misc_desc = {
+	.setup = st_misc_setup,
+};
 #endif
 
 #ifdef CONFIG_ARM64
@@ -179,6 +228,7 @@ static int acpi_apd_create_device(struct acpi_device *adev,
 	{ "AMD0020", APD_ADDR(cz_uart_desc) },
 	{ "AMDI0020", APD_ADDR(cz_uart_desc) },
 	{ "AMD0030", },
+	{ "AMD0040", APD_ADDR(st_misc_desc)},
 #endif
 #ifdef CONFIG_ARM64
 	{ "APMC0D0F", APD_ADDR(xgene_i2c_desc) },
-- 
1.9.1
