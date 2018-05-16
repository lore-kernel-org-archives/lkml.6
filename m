Return-Path: <George.Cherian@cavium.com>
X-Google-Smtp-Source: AB8JxZqTrCbPXtmxJVowb/bwyOuW73Dx77pEuFOw6/6Q4JxYqPwDmfAfFIvB6bK5M15/b2WYab2V
ARC-Seal: i=1; a=rsa-sha256; t=1526454035; cv=none;
        d=google.com; s=arc-20160816;
        b=GnSjRHnZyX3R9Co1ZBDSkp2Fjgz1safsijruobjl5QFuTBIXE5z56FEmbxaGnvGCp2
         jhluKg3JXpqeD22wzSsean7thji2wnF/DNXWKuFqWjkcxTbp5NQlFVYS4BSJdN8vJ1pm
         XkweIag14fsvCbYv729OTwI/ayMRsnZEPIrf5u+a7IL44hJ4NmpPAH9TehIaA/R5v2ky
         Iy0Fj/bwZjm0u+uKTNM0yNRMIh3Mry1N2+AyWEZmkMnf7O9jiJpsk8V9C8vqJuKG3HQT
         JzkSw/3rbAbGRbhz3ydxVDRzotMrap5dNA4uLsDuIoxnPyGJYk8ENszmFtxf4rDvaGEG
         RUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=ZL1/jyfRbSI0tueyZiUKDzqfwjZ2yxx61ZQCCKXqjfE=;
        b=IlW6XeKP/dqGMols0y8vyJ4eGras8K+5AASkkho/z1A6meLk91l0/Gx8btGw3iAAaz
         wE/NNT+WAhaexY5nAi21Z1DcIZ2nPB08gEMnwYtzKCSnuQsU9KHpK/GOYgtL05rlkD/g
         JqHldK/3P0ji4mnHGbhoCllKf0GUEhrOEVYa0joDcz9nYZ5jyXWK4w97lCqW38XcXoVy
         C2sa18svsrnhyKYEMazgpu6H7rwukntguMA/fPlsE+QXaWBHTy+fN1Fh5G7eoZvHVYNF
         VnxT1UMb/mEjJQaQkEWDE7nqVAgsRC+r9QSQP7DWAt8fOURCdvOkh1O+vxdQgRNP0bbJ
         mLDw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=lQ9J6XTl;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.79 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@CAVIUMNETWORKS.onmicrosoft.com header.s=selector1-cavium-com header.b=lQ9J6XTl;
       spf=pass (google.com: domain of george.cherian@cavium.com designates 104.47.38.79 as permitted sender) smtp.mailfrom=George.Cherian@cavium.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wsa@the-dreams.de,
	jglauber@cavium.com,
	kamlakant.patel@cavium.com,
	mchehab+samsung@kernel.org,
	davem@davemloft.net,
	gregkh@linuxfoundation.org,
	akpm@linux-foundation.org,
	linus.walleij@linaro.org,
	rdunlap@infradead.org,
	george.cherian@cavium.com
Subject: [PATCH 0/4] i2c-xlp9xx Add support for SMBAlert and minor fixes
Date: Wed, 16 May 2018 00:00:15 -0700
Message-Id: <1526454019-32714-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: BYAPR01CA0033.prod.exchangelabs.com (2603:10b6:a02:80::46)
 To SN6PR07MB4926.namprd07.prod.outlook.com (2603:10b6:805:a5::27)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4926;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;3:iLMvYBnPhlePg1LPV+61EyaNPazpxmFWOOcIjALcZH3OMKPFq/VwICIZQI5HL8AKhb2O9LOzh/J5DrO5e8V4jFeMA1c53fBuOfX4JgFoa7LsjCpahMGP94MpxAhIq6h3kYae317lACH0VT+eaT9Qc4FjeuW/v9r0RKgFUYnblQW5YMzONnq/zPxJbta0kYH5dfVKqZHP4bI3COhEDBj1Qg/F5RJ6FwyP7Mf+4DErT5x5JHTzs8Pj1LYQUp59L30Z;25:6yF+ktsm1B5f6VyfmuF7Pi9kcGZv4hvEu2klEGZMlD8UlPabeVmRaYezh4RsueDBJFlsGekS7pFG+3+Gdps/gHvwZj8nD/3GSjXxTy47ZO7+TA7+Hh65JEMJNNW89RLm5soq3Ew32OcM5BMRQG1Qw95QkeIIolBIK9vxLaM3OsJHglBIqqRR8fmh3S+heuibV+86z5JBI8uyTHf/qT4c5spuY71ilA3UTgh0e8gPxVkk44kHiTFNindvXhH0dymxEBCfmiQKC+lp4fTUUkkARq1nDJySOFGJCpAnsuaRUkC0PpJ0hskVX25d/wQL0EGhw8z6IQEnLKWNubaFq5ZzDg==;31:BlyNPI+OeS7TAeZiiltZFRo/6QaHPDeKrdki9oZCMIxOB37l1C7Wm9sK9YX8InRYHUlA4NxX4SEeIUtqtVkfUT8XnFCXfDbz9Ggewi3Fcd2Sb36KRTrbw9irrwjVq23njOGnTOEid5qIiNdjwJ/H74jnIx+Cob0ONLcNuPUcCWWqQQuwONA2scFyPYr8tikDHZ0LMSNj8OIx8HY5QHtzfSOeb0BWE4JSDfrKYHlxe5M=
X-MS-TrafficTypeDiagnostic: SN6PR07MB4926:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;20:SvGDbETp6UIyi1SOreW9OMukUvgDbOqpa9/K38PxtoeO60UsiKJUlOqcRs7Ukklu5m0F9l/sKpR9HvszLUMrIIxK5wpNmuMwTOVqSlm8u/KHjg23ECjcRIgmcvjZ1f4yeNYbZUeScARd/AI2AyLGYBpROJXAtMBNoXPwbx23zgnXrhrh8KWm4flBs+G2LdoGdr1K6p087ihXy3Ua7BAFDFmlQIsnF9CbH9kwpXr/nu42ESfGkkjyyFQDyBlp6jQEFJf5tET2kvyijWTd2XvsvJQw7x+q8h2qbWbPmhBDtYDKUklVoK6YCy4oKwhjh85gcB30Vjtglnx974lC/86sN2Ah7EU5Pg1Tms82L7eSIJgazCR5uGdXd1AC79Hp5j1Ch7mB99XJPWp2DRKZUXDploCYUhW5ryJUxpYZBMBUPHZzK6k9ihDDNrRtT0NyRbmtrEYKojHI8UISq1lUb68913iNhk96Dpetlg8aMllI6lnZOBixlnI4nlU/Q4I+QtZy;4:yEMEs6LeDOLGKB6YTqNPihrKdp7xYZPvnRHgGbkNF3vfWSMFkzMnFnO8/LLSW1LCsJFi0xGyZZYgRXbxabjGzRXGUBMHdgXxXXwLlaD4hEGsRq8YcSJPSv/3CuK0eZ+nTrbwVOJS7Qo3iqPALHh6+G3gT/scZuYaYiFvV+R0qn47jSYlTXqvJR+RtKjPuI6FSvMVRB5HYmILNZc/7p5ordGFaLooMVMySCY23he5/O/R3lwcOlWp5+mNzV9m6vlExrkdLihNBg4q/VzkK4BW5Q==
X-Microsoft-Antispam-PRVS: <SN6PR07MB49262E5386EFA17D8F756C48F9920@SN6PR07MB4926.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4926;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4926;
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(39380400002)(189003)(199004)(44832011)(50226002)(7736002)(50466002)(105586002)(486006)(53416004)(36756003)(8936002)(106356001)(5660300001)(186003)(48376002)(316002)(6486002)(25786009)(16526019)(16586007)(305945005)(4720700003)(68736007)(6666003)(72206003)(478600001)(476003)(2616005)(3846002)(6116002)(956004)(97736004)(4326008)(59450400001)(52116002)(51416003)(2906002)(26005)(66066001)(47776003)(6512007)(81166006)(81156014)(6506007)(386003)(69596002)(53936002)(86362001)(107886003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4926;H:sbr2s-28.caveonetworks.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR07MB4926;23:izapKfV7Wrn1iYs0VOz1JcWFo6yJpmOw6Nnb7ql1o?=
 =?us-ascii?Q?dFJ4sNfvBj8jMFMOIc0WTwJgyXX3Aw7Y2CSqzjBtck25+Q2vXTid+m3McQks?=
 =?us-ascii?Q?CFpz4U+V2+Zc3cAoLC5V5H1TROIHt2H9RNv68M23HvYAVNUMWMPFSgN7L6g3?=
 =?us-ascii?Q?iA5P6piMZl09/dRgBYPH/A9KKaIPtSO4usmHszsMpO9Gjd4IAlcW/k5cnTzN?=
 =?us-ascii?Q?JmBobFnUi6gPgHqhoDzGkFvKEIBSUt62dm55Sgb6vmB7atuh1G2Yi97nODb6?=
 =?us-ascii?Q?sQcONOHZNJEH4QhtzqGzJL7qlyk34VMlpZvO3b7p1QK0sAi6qi67I7G/eOmA?=
 =?us-ascii?Q?uL6xlj5f1XP4LP6f6lCMqhu8yPTm2IQHT12sVAK6cw4bV3eR5uOmLs23JGfd?=
 =?us-ascii?Q?OaZqedLap+hhSdI884OnXQHr6VrKPJs/DGtMfc5lBmpEu1yC0qMnSteXQwDf?=
 =?us-ascii?Q?F2+GsQ4UlP8DcBIo0VZL4rPAXmmoo29hiAyIg4g9HgF2pRO3vm3tpP6PuXRN?=
 =?us-ascii?Q?1QYtA6ukDqIaxYOmy3eQPrjLDArzgARD29sNf1fsWcp3tBNieVoOl2eYtKJu?=
 =?us-ascii?Q?a+Gj9fIIKlLxPTueoujLW02gExjlQQK6Wyjcn4K3A6qJLLI90xiBvHXCHgQ6?=
 =?us-ascii?Q?Rokzc0FhVabk+02wmu1JpLb0PWzjRHGMfuDOzpdHaCV3+UoKgObUBlo3ODe8?=
 =?us-ascii?Q?1Jd/AHadwqi5qMbWx9vis+kMeSU2oPyv+hHYZthCriZ91HGUv9nJhA7x4vY+?=
 =?us-ascii?Q?88XY6+rBhUBOQgj+jPJ68RAObuUyn2+rFExhfOcPOewLMquJYTP5Bjbc8hl1?=
 =?us-ascii?Q?f4nTgbjtp6BZFLw7RlT+J9vqwkEULdwb+qQ2MRSsqUUUUXiGbsMF53rwRn4q?=
 =?us-ascii?Q?tbDRnnNq3Uhw6raVkEC892kQU7f9Df6hWSwVkJ3amVFEM4uSj6x92P6VtGIW?=
 =?us-ascii?Q?ckpcsTMc5nOE6rGmVtHEB9qhAUeb0GK5bvBuhzsg+23GD5Lvxh2yA+IngBI8?=
 =?us-ascii?Q?ewDXrMMia/J5Qm+k9Cu3Mg1SAO+na4dlClxyXNS8ogLM4psfcWy3sl2F0pp6?=
 =?us-ascii?Q?1C1s2ZF3GcTGQ8ArxYCi/IOna0SBuIOE6x2gpbrnyFnDFZOg5AzYtfE1abbE?=
 =?us-ascii?Q?Odb9aQPl5qPfj/xEqw/A/U/KZn/J57f0rCtNUiKJvXV3UtXrxcZo6uluYEFi?=
 =?us-ascii?Q?9hUd4Zeom0ML4mhMaI12OF1z1h5QbYnQwHsYJWY8wuw2Y2mZnStDq+aE+yjO?=
 =?us-ascii?Q?XB1G7mP8YUNy4mYUIG4YVcWvV7llVsUes5OYyPL?=
X-Microsoft-Antispam-Message-Info: 8gbWR05TpVvMD/j6Tom1BsKpeGw3oZlFeRGV12bYGxaoWatraFdIMj9+yUTeVxzBpKjwDMTJ1HwHcOeNRPY0R0/L4GSqgnWUZRp5Ugh92wuNzAofXnt3i75pV1re4mvUIw68jASJqgUaza0iVCZW++nOXbPscdZxdufVQwBMMomhTxjqSE1P4iY4iWN+Uuvc
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;6:dYwV0W4D9Ah8mvGnk03UX+wm/z/Xi/LuVjwwFM0k7OjPpoqOA5o3axbGnb3UbbbdiYTGsnkehvKpiPqoWvyWHExGm/pCfbvA7Gg0AWdmqFKgUgM77IwR01JOAVZQg+qtEWUnRaPbkptM+bX8QdUt6XTySHWj4SlZdhDKzg89zcNDd7cyvB7dKg9WrJINC6yRYm8muIud36lr6v6ZOdQ65KmD+vptBLGQMUda79ySXX+BvHQBjqIN6Wd40IyoEsRi9CU+3W4Ug4JnArrFOir63OPEBA81pdG8feEISWECBjbUjn+v1QTKyLqA0RL/ZV3XCwwdfGv5+VEdXFAmDrsE4PsvlzEPOQAnIB1JGN+hwLuhlKLdB6cvtWdGZ1o8hmfx52Fh2hUOSO4AmHGg/ZiMXpetbTFtKPdDItelDdFnJnXZ0dxpvMfvsmaY8d9ngEDmko3KWkZt5B5SC/VD3W4jGw==;5:43SxG1Q4dsES5RhMQkiT5RorxPrn+ydlCmnXmalhxwv6Sn0J9+yyrhUroU5QR5ebTrk2J4WgPlEsw9mrYh5TFUpWj8hicj43ciT2DFnagMwOX8u74fAfbb89yp4vzuJMJjLln9oqucVKROHM1EmwvSngHQS6HZ3s9qsAC1STfZ0=;24:/gtRbKC+Gj0O4Wd0i19llvaecs4wJXSOQZuqoXIA043cPITQLkppCtuI5d3+ZJf6URzqnoQWrj1WvK0rniMSr6pcPNjeV4ymVvKHkbXMOxI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR07MB4926;7:6kv8sbMg4NV5sRlhZcbwlnW6yeKw7oWangXRsRsBm2jTF3biUBKSP8OS95RmU+cTdd2Uz7lPOYnoSLhLbdGSWr9tOLAZGJT7XbK/viOMu30TiLVFiFqedfItxnQyPRmIRDqlhLAjT4ZvnR+jBIyqIMItoUyKkoFFcMKiYHbqNUtBMeqjzWnUQxFDtUyhwP919lT9Jfcu1yhDIdmE681J0SPWtFGDfpbTPqzxoOmj0gXVDagJNiRDKUCPE2RqmyF5
X-MS-Office365-Filtering-Correlation-Id: 31e393fd-dffb-4ea1-155e-08d5bafab803
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 07:00:32.9519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e393fd-dffb-4ea1-155e-08d5bafab803
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4926
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600603066902022250?=
X-GMAIL-MSGID: =?utf-8?q?1600603066902022250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series adds the SMBAlert support for i2c-xlp9xx driver and the following
fixes.

Patch 2: Make sure we update the transfer length to a future length.

Patch 3: Restrict the transfer size to I2C_SMBUS_BLOCK_SIZE for transfers
with I2C_M_RECV_LEN is set.

Patch 4: While at that update the MAINATINERS file to reflect the current
maintainers of the driver.

George Cherian (4):
  i2c: xlp9xx: Add support for SMBAlert
  i2c: xlp9xx: Fix issue seen when updating receive length
  i2c: xlp9xx: Make sure the transfer size is not more than
    I2C_SMBUS_BLOCK_SIZE
  i2c: xlp9xx: Add MAINTAINERS entry

 MAINTAINERS                     |  8 ++++
 drivers/i2c/busses/i2c-xlp9xx.c | 89 +++++++++++++++++++++++++++++++----------
 2 files changed, 76 insertions(+), 21 deletions(-)

-- 
1.8.3.1
