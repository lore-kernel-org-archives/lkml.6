Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeEDRJb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:09:31 -0400
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:28992
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751425AbeEDRJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:09:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
From: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: djkurtz@chromium.org, akshu.agrawal@amd.com, Alexander.Deucher@amd.com,
        mturquette@baylibre.com, sboyd@kernel.org, christian.koenig@amd.com,
        airlied@redhat.com, Shaoyun.Liu@amd.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/2] Add support for general system clock on ST AMD platform
Date: Sat,  5 May 2018 01:07:17 +0800
Message-Id: <1525453639-30575-1-git-send-email-akshu.agrawal@amd.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::18) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2366;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;3:2wrKGBsmZQpKoZDnhV4cVcWNn7rp3kMZ46j5DPxw8GB2OSdXj1tYsuRVqXyKrpyLrs9fOhpX48e8vAtog/sin544uu9XJJSUSEVThvT5/U4ihxQo3IMdffbLWhKhplljDNl2IShu2tLC6mkYWwZ6LqHuOt+IRy1g+O5eU3YtCY9SgK26R0q3zV9Uy5cxleQ81CqQResgnKGbHZdMTxJq2/emBIiYGAjvdyT3CVAn4OFqg2z14GGAmRKyzfzsYOtO;25:zm9KP9lBvzdvKb/sAhosXxwPprjbwGs7ToaQ2+wQaXF9UmI+7rzd2Yp9XxEiO3fKt6M2+p38cbwGzIVh5cWL+f0sM+q6x/Bfn9XkYvKYOzsYrpOTQMUxkjom6OLAf3VfA5VYQVGt4gOZvJ6It76w/m6ePq7M2ImSvA+Jp4P12eW19r+MLy/yol1a4RP06j51PHGE4gY/icwTrc43q0IAei2pO2wYmN7UtZvuMP5RClBzg3K3mYNO1QD/N5sfUEQmwlqdkLNUARRRADhHgEJDAWLuU9Z/xw85mO2w72YERt0tFPwGZaUMPSDgWq0Z/6qeUPPFjo11vixH/Ci9MxWeNw==;31:gyoGTLSI8lN+4e8qDo2Pwv+kuAf/k77TjlrdY3Pv6yA4+xNgrJ3rXyp9+81XOiDYeLNQf02XcLFRM22DK8IaQv9vYy7S8Td53rLLw8tdH4iib5F9tEaV06gRAoxR5j+XiwVAOnIso3cx6/G0adfBMakSUzGpgaZ2MAZ9L7JPUO3ybFpdO/Khz40FCEYcuhbKRIL7SVBQ7tN16VxJOnhppLq2YR2rn+QI0WLHRkAI0SM=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;20:dmcDCwujC+FOyeXDCpUJ9R2sflizhni2cCCKratJW43Kziw53j2zZdBRZGJSjfIjlLJr63AzowgM1zvruMZVDmK5m0G0AhXP+MjXvBj41nA5tiovfjT4eNj+9d3GE5ulfPM6ujKlx2lMeXmxzF+jnjOTqjV6epIho8sF7bXfSXLRMna32IecsyrNGQGQ26ifpwau/5ZrWO75Vlad4bZ9Y8b3rFechgERkMEqxzkjR5E8uLU2Y/ZV4k7A4+mRV6FHi6peJ47gOFfvq+kU0M/9CvNH2O7jiljqEnF+LcynBKI0gilxsu9hldu/xpSMXlnpL8aNHHfJ1p2B6IOhpB3VpFo2Y8RGjhkjyYuWAtFh5tdIlBQZRJC+abKLF1zjkVYMJg3AGU1EeS8hgRQGENF8588ynEYrDPXY/RHyt2GDJ8ZsQ+/cccWyDlEB9WLenEoOj6RGwahOmYyEdh14cnY/mp+QYfg5JyTthM1vdHthqNTURhtFspZJyL7ailz6ugr0;4:ZmBUm7cn79mEdSvmC1qZEjkoRk5v7J0Hc3P70DlNj9Id3Lu0loLpY6nsSfF0IOQ4VQeHLblJ0ifSdBIQlIsYo9NQ3GVDyEDMAKYZZloF7zpZHSaiVsOVM3veSME0z4jrGf3PSvnNnfV95LMfKO6pMofAIZ6BBzXtqwhZq77goyiI8ZzSt6I9tlfVEhDaenSVOdnJGoeMuM7RgdFLFKWK+Lv/T+l5zPfixAw8a0ckvOhgAH7Fk8s+rgbSDwyAxkdOoU5o1NNIn5Hcp4/60LEoYA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366B6CA26548C1D66BAE01FF8860@SN1PR12MB2366.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB2366;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2366;
X-Forefront-PRVS: 06628F7CA4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(376002)(366004)(39380400002)(199004)(189003)(26005)(5660300001)(2906002)(50466002)(52116002)(186003)(1671002)(106356001)(68736007)(51416003)(36756003)(7696005)(105586002)(4326008)(8936002)(48376002)(50226002)(97736004)(3846002)(44832011)(386003)(109986005)(6116002)(478600001)(72206003)(7736002)(305945005)(486006)(53416004)(16526019)(81166006)(16586007)(25786009)(8676002)(6486002)(86362001)(476003)(956004)(81156014)(316002)(53936002)(66066001)(47776003)(2616005)(6666003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2366;H:akshu-HP-EliteBook-745-G2.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN1PR12MB2366;23:OmI7qRmp9yv4ftw4tzjK5N+1P1NhP+1zbjceCr09A?=
 =?us-ascii?Q?BKMHF8xqWPEC2fhcA/if+fFa9cZ6lagIAXUcVamON0Vjj60pGSJbpKA4jZVk?=
 =?us-ascii?Q?XTe4xem9B7EQO6l5cGvZR1nyMSW2VqLrKTTFkH7SE/dfojMpfLwcsSDnwXz4?=
 =?us-ascii?Q?TlFqc1RFuT1IU7ET6Eb47Gtmv52M885Ur5rwBa+HcxbWHSiNJaB8F4T2N1TY?=
 =?us-ascii?Q?Ls736i000uB8iAbl01H9xcgN5iusHoDRcuasLqb+XTZNSylCPTA3lwYmlKRB?=
 =?us-ascii?Q?FidY2I4Kml7nE5N4dPTjdiah3stWT4SgynQeBNFCLmxbkIGTzb3KF8tL//md?=
 =?us-ascii?Q?efPBDv2FjrkfqWI6eWgQbo4LZBCb/9EwNGZFoU6hrrpuXauKwnnSWJrzVg3Y?=
 =?us-ascii?Q?zD+SVV9HybsYtKZv5LAliTNu9wlhowzc+hjDgzC+nCgNgznMLJibvV2Gz9jU?=
 =?us-ascii?Q?F94soHUSXxer7aVOFIT6VN9VkrcEvdqf00hPEMMuImpu2+6tJIVSfPG3M+BO?=
 =?us-ascii?Q?T1wEWdM6NFaH/VNGeBlqXIXH08eF71V8FYKqwX/sKaEwBlizkx9FoI1X8orm?=
 =?us-ascii?Q?aVcNlGpRqkRAGccpjSiCGR8EBPskZCK0HSe8LNH/s+wJHdiIVIfneLR6jx6d?=
 =?us-ascii?Q?7fGFPn5N6U3Oe0jQY3zRg/+0ZbzNVO/ctDlEibnB1PwwthTQ1KLEasjRamSN?=
 =?us-ascii?Q?X9Sp4lAoQuDk2Vw3e/XaSz/4HfPoPMOnRq26ToZjcLaWODv6ZD5lWcUWBX+u?=
 =?us-ascii?Q?YygL0xQwOGQVL2N6ZY/KmhTEdg8uXLgWsbCTT2TRMc5JR3bxc8RBrXUk2SqL?=
 =?us-ascii?Q?eWDbywn00dWxzacy/PiToFtRcrDi715dwpQjGNag0bM1wwuVtocCC5auzoug?=
 =?us-ascii?Q?GvCTh7+U8SGCP953O1Rm2OYGuhJ9JObWkj1Jysp7uDaEB16zyGox9326+Cur?=
 =?us-ascii?Q?Ze13KsZ+uJPOkupUu53xUIy5G+luzsbUMYtFqX7AwKA4LfdVY2J7E/6cKAo+?=
 =?us-ascii?Q?4O+p6uNeh+KZE7CPaCi+W86N68M2opwFo198zjaI8f0o77KT9Gbapp2DTs1u?=
 =?us-ascii?Q?Xyzx7y4m8XfXRuuLa5pqozHEHDgagK59f3nIPz7t2BXI1ZarIFzaNdhdO5BX?=
 =?us-ascii?Q?U9pNckKOIFUkKFJXBn4Zz8irM7bfeKsD/SmeyGwPYDPkVfUKitf4gEcXzA+m?=
 =?us-ascii?Q?aYfnXGRvvO+QVUkuwS+8wWwOByNhiB/Yw99?=
X-Microsoft-Antispam-Message-Info: r+LFa0VSJIoY+J37CqMzChKsUUI4vNd1Q1QKvhxRvrT3IggIi9iXCSpgo3RX7MFsxMYiDzCgC/2jtT5MHc0MP30tHDnEacV1suNDDd6q6BnkZ0n1TKXF7HJwLKA9Ch2UycMhNbnOqoAtKlN16IUD8Rei+9F4jbZCg63Kx2cqWlacuznu5oUDAXtC4IuMJs0L
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;6:MpsPGNWC/NYbShXousspmZlWqizazCtAzaCN7kzjjPrlTNxVoYtwWCPAP9MCRWzZSFstGk5JoMus9SnG9FzmbxNcJYlCYsDdSoSC5Hkd0Jo5owuPGCzurgbyl1cfgXfbkVHbWn4E83GSaJdwk4RRYhJz4IDHckWYcTtv/JW4WAKkiQ9x9PHhTxgYIGBh5/8YJcv5rzmSu1QpcWYHDtfwPRsyUl6/AldOJEgS5sxE5uooZmILeV6vEZhQ3/z9YnPz8LoIwb7erPj8TEtCmdpLn+GVg1q6BJCwP+x1qe2jotkfMliLjD5a1HBotBOTKiWRs8YlAd0HEOxy0Yjy7V7LzTe08bPUoPZ9/MnzVnRFCFpz+ec6LMsyfx5riflhs1VKT/zg+tJU8C/7XtCQ2pN+xagKp7qMsL72Ndfsfb4E/aZYjcXw9OD+iit+8oALCN2wQ/RTH9iAG8CzXijGm128mg==;5:rX0Hr0gr+hBf2x/htGZkFvTZPPmolkEV1XeMGH6AVFtm81molkWVwETPCZXtWQUSTkO9BrXP0ziaTdBNf4Bu1x6Y0DH2mhTQF3+DqmZ8owKPkeuhO6PTmrzlc5M/aImChGIiG7EGzzI9tONUeTLDgN2SSt3VYInSH8aGvrmKgYw=;24:oYwCEhN56OPKFYj1gcKrth02V5Q8ririsM5xJfMy5BCXGQjdY8EfgymhvzbFqgkoWU9jdrurHj0Bz1tmW5IiKvO95VDv/lh/5yV14mo6ag0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2366;7:QCo9MATT2WlFmzA8JHvO8U6XV44GInT06Ty9TkFV6vKo9xU/BmHaL8NFvVMuaHyOOxFU4z978Ez9bnNg1Sqq2oT1y/QnMor5uWeW7tY9qHuoFmIphsIScxsT5OQf36pSu79rB6IqqqxuhyuZnf3/KB09MkSgXyk1Qv9gXL1+ewAF/Vsvwdp8fSyQa99PMJR7qxulsDYoXcERJ2biMkR/Je/8I0o4arl5kghc+W7+IHSM6pF/a2pNYKBZJgMwtH6b;20:pk0TeXbTsTOIbp//8i73Ftjj5n4Zzr/s9JU4w7aSb84TBWEH9lgNp8813lLKRlwHqL0RdbuEorbW6vs+4xTlaMoN+N8I5RBTvtN81Hb7pS3hOxPdxSVnqqftkdnX+hQ6fltI44rj1iJgAVskwugKjxQSFPqEXCO5K2ZWxSxb7qeG/C11qflUyodmrhf0mCpe5+AiJ76VSaz11eo6Pa0DbcZUMy94itgRNPf/Dn7EIgzki/B5QaDUtw/MjIn8rwOQ
X-MS-Office365-Filtering-Correlation-Id: 4cc49479-e58f-4bac-70a8-08d5b1e1cad3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2018 17:09:23.6717 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc49479-e58f-4bac-70a8-08d5b1e1cad3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD ST/CZ platform provides a general system clock which can be used
by any driver. Registration of this clock will done in clk-st driver.
While the ACPI misc device will create the required MMIO mappings
and pass the same to the clk-st driver. The clk-st driver will
use the address to enable/disable and set frequency.

Akshu Agrawal (2):
  clk: x86: Add ST oscout platform clock
  ACPI: APD: Add AMD misc clock handler support

 drivers/acpi/acpi_apd.c              | 50 ++++++++++++++++++++
 drivers/clk/x86/Makefile             |  1 +
 drivers/clk/x86/clk-st.c             | 88 ++++++++++++++++++++++++++++++++++++
 include/linux/platform_data/clk-st.h | 35 ++++++++++++++
 4 files changed, 174 insertions(+)
 create mode 100644 drivers/clk/x86/clk-st.c
 create mode 100644 include/linux/platform_data/clk-st.h

-- 
1.9.1
