Return-Path: <devang.panchal@softnautics.com>
X-Google-Smtp-Source: AG47ELuBHzJDX32JkMloUX3eK7wPMX7a4jSbU0tHmUe3yyILLofVf5m8HoTXxjWNbDJAoAqKIX/X
ARC-Seal: i=1; a=rsa-sha256; t=1521610487; cv=none;
        d=google.com; s=arc-20160816;
        b=aEa3bEhg1QS5O01Qn1DnzlN1uz20I4KxPqZhAjb0EJzP2Dg8FDqlYCJ72EQIVGcTuo
         ar8HtB5GfG0HkucQ1kyIo01qjidg5Ii6J/9EpglWRP5QECzU0aJTso+zvkqD7i5RSWzx
         PxjVGnUkoUjij0wlhPzm/QXRN315IpAZ+4cXn0svGDIgw4Zta8UnmZk7i4tdRXukANaK
         uSfGb6SfBUWQGYN6mR/t/Ue0KSxGkUYaclwEJQ74tNCga1q4kol4NoYfJsEDHxs8L5tj
         xg5ksld+DSgS6YOXzoz20sw26hKx3kt46eRvqkvF9XL0jiO4X9dxiAbEFApC4xZ3lw+S
         8cyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:message-id
         :date:subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=AhvPVYo/Z/QlVoueEzoWLG+EUze4s3UuUrJfkqC70+g=;
        b=DOeVMxJh09dkPeK2ZoswH8PvAtbnwPBOA/YYjDeNa9xobZ1GrtjE1LPgYGf1RbE8Bg
         MLUHof92aAhy3mMzZEpU9buuS9qbyTIBjNmhOFcWBmxVT8W4xtefsDLWDRPkxcupQV+w
         BX+S4KVblDujjVl+kje+Yd8CEQREDVPQMMzlPSb98WaY4oSGYMvPRmnn3nvt5o+0eItU
         Boq9AfMSNBCLO923TFyBWR67kDqJ2seIY2Z5xgmfiHyCkU6w0S6qCTaudRrkPYDBgKZe
         8D5wRPGHnnVja7DnkuGjX9cdGBGOUB8f0SvP2I7Cvfw+jRhQrCicEvksBGE7aagbvpLf
         9GSA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@softnautics.com header.s=selector1 header.b=oXGFmvsU;
       spf=pass (google.com: domain of devang.panchal@softnautics.com designates 104.47.101.103 as permitted sender) smtp.mailfrom=devang.panchal@softnautics.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=softnautics.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@softnautics.com header.s=selector1 header.b=oXGFmvsU;
       spf=pass (google.com: domain of devang.panchal@softnautics.com designates 104.47.101.103 as permitted sender) smtp.mailfrom=devang.panchal@softnautics.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=softnautics.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=devang.panchal@softnautics.com;
From: Devang Panchal <devang.panchal@softnautics.com>
To: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	geert+renesas@glider.be,
	robh@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Devang Panchal <devang.panchal@softnautics.com>
Subject: [PATCH] eeprom: at25: sizeof t should be sizeof(t)
Date: Wed, 21 Mar 2018 11:04:35 +0530
Message-Id: <20180321053435.9080-1-devang.panchal@softnautics.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [219.65.63.222]
X-ClientProxiedBy: SG2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:3:1::24) To PN1PR0101MB1310.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:12::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85773643-a03a-4c48-3288-08d58eed7333
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:PN1PR0101MB1310;
X-Microsoft-Exchange-Diagnostics: 1;PN1PR0101MB1310;3:xp3scw0Ee0ZgHm4obEk8VD8UExr3wluA8vflpreFCjQNroXxIwJTQch+lBkTSN2qdsfYMXLJXWjSQ8T1RjplvwSeq/ZJCQcP1Qs8LirJD7JTe67nO87EuJA6d2p8vyR5XZtsm7rOfL6M2l/5apnwKH311lZhZotFoVo0HVc6fFOTrEucdhNCgOkYKYVMDuHyrtXeaKnMiovXfWadcuC3o6/uTcNmN0DwscCO9yUEl8+9JvEpIi2k3JQjRkOvKcuk;25:CVRd4b6bwrTaDPT88cBjqUdPLQAKmyYEgQq9cpf/lZr8Ujttm9uw2iN6KwUVGJCJiF8xtew9Iijlu8QvpCApKHymJ5OwgpJ5chf6vklwWr452fZa3JwKr4ktveRWJjzGcDfekbpfBEqFKTKHgwHi/n1pqmVGvl+2z40sxcp24cyHja2/DgAgVVJ0r1mMeA7lPnpva7iMlK/pMY9XtHmPA6Z4sqCczn3WgwCGsjW9UaG480cwmQd5rPupD9OIhTh6Ge/pK0v9yxO/NLPbEQVk76lrgV26GzWmUNAGTH9usAtwyiathinUs+JQ7HlMIotzp4OQ6Bu7n5bn6k5g2uJ6yQ==;31:a819TOUa3gw8uJ7Xw/4/DSXWwPgmAkJzbhKmNa0IeWHkf0FzLSattaUBSlouUkiTmd+1g4WpvfuoZdPg/k5OztOdywUP3nInRGZQuTZQjk8+EwRYrtgmD1ftCfIivlL4Sy+z1b+lErsb9r4MA9t65niYK9E98XIldMMMFhiVELa0YDd72xlaWf7hrJtIM48+NxqJHFHrwuZTtNvUgyYiWkP0nJNHFlJUjEuZn/5ta9M=
X-MS-TrafficTypeDiagnostic: PN1PR0101MB1310:
X-Microsoft-Antispam-PRVS: <PN1PR0101MB131069FBC1E0524538E55D2084AA0@PN1PR0101MB1310.INDPRD01.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501319)(52105095)(3002001)(10201501046)(6041310)(20161123564045)(20161123558120)(20161123560045)(2016111802025)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:PN1PR0101MB1310;BCL:0;PCL:0;RULEID:;SRVR:PN1PR0101MB1310;
X-Microsoft-Exchange-Diagnostics: 1;PN1PR0101MB1310;4:skjIA+f+uYHRQDOWDGFbHsn6xDEAncWy1mHsfnFbH46sdGIB+a5g+cRELUW0tg92dmVvLg5s25WWbcNZTEZMTF8pYSaKmqOAudfjCC6+zbO3uxUJNbAJOClJLKFGTWaSK5UcoATtqy0XqCX2EMFKUXQYabAC1C+3FZ7jBfq/TUTULIpBejgQIMv03ursJU3XORVKEZTorQuIxSQR0XMo07B+vjEDsg8VqWrK1EWJw+jphgS3JQ8kEKiAlXwLP10TlAkZsuPv9o1xOiLep3+kow==
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39380400002)(346002)(396003)(39830400003)(199004)(189003)(53936002)(2906002)(81166006)(36756003)(81156014)(107886003)(8676002)(52116002)(305945005)(7736002)(51416003)(50226002)(386003)(4326008)(86362001)(6512007)(66066001)(5660300001)(6666003)(47776003)(53416004)(59450400001)(6486002)(6116002)(8936002)(68736007)(26005)(1857600001)(6506007)(3846002)(25786009)(478600001)(97736004)(16526019)(16586007)(186003)(1076002)(48376002)(316002)(50466002)(69596002)(106356001)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:PN1PR0101MB1310;H:devang.sibshivalik.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;PN1PR0101MB1310;23:T5wCfqbWW0qlNvmL9Owo/sefAkKeA0P17Zeb9kY?=
 =?us-ascii?Q?dAjsz/44ZJH0AYFwRrYQdkcZkpkxrADLFht+5p97C7TCB9gtqqqKPsRBp62t?=
 =?us-ascii?Q?83vEtp3Qm12oPjcgPlyPNlRRjE8zOmrn6NsgTayhXl0JN03cXlNjjdZetk5l?=
 =?us-ascii?Q?Gpe4P7J1OiuzqVgXe8NYiOaUEu+E7wu6yT/9cBnsDCcurxKMowRcdId3Ytmw?=
 =?us-ascii?Q?xnO/9EgqXtj3SxrQ2AqEyw9ZqcFth8MeOaud7uhLUllWwZBjP+MsEP37g3Ne?=
 =?us-ascii?Q?gLGRN8aohHYl6XTGMYqFwMvvgB1Egt8xs502zvhYubXdQCPhNYTQkZyMIq6x?=
 =?us-ascii?Q?MvJyzcn/EMc2kek72LjImWOHAG+Tj9koF9mbK5qbVC0msJnSJVcgOcktBgaV?=
 =?us-ascii?Q?QqgGcXJwFEcd/lMYlPRZ1nmoJqZc1ZE4pZsF6y9WeClrSQUmEf+n2p4Ctfg1?=
 =?us-ascii?Q?uC3gqW/BGyoiMobbnkHXQGlTkSSpMXpFziN9wjAWM8JS0E4ll29Ow6tC72c+?=
 =?us-ascii?Q?Vak+MSQjNASu69pCl5ID6xWPsdVWuQleaT+RYjWjLAi0Ha3YB+yi2HVfZoTD?=
 =?us-ascii?Q?y+84939FxvI2cx9yj/Kx1mY2iyallf8UVjx1MWVUDFO4Gq9FmVM4wLf0j6vU?=
 =?us-ascii?Q?CFDIHsTg+OxNCQZcEv9MJrrJBtFRnk6WO69VX7oVvWbXFhqGnWA67XPWisLl?=
 =?us-ascii?Q?IHMMYzW6m51mDFpGtiMO1GRixk38+HchtEWMFQQ6/k/ooqhdqtd2trPNzYis?=
 =?us-ascii?Q?jIlO6Ay2dPmnZYIVxKvwA0IoHf/YkeA1Au79na8Cs8ew+6SNNP8RIyNi4qFn?=
 =?us-ascii?Q?qFqEBWvcfcxTq/CPeyVpcpKUgoCp/zXYMG8Z5HTZxrITdwBYB4XcPqnu7f/M?=
 =?us-ascii?Q?cFvfqGFQhh94vhrxAHjdJfNYHOapOaBvo/Zh88fwtv8FJ/yUwWT8F12Vv0tN?=
 =?us-ascii?Q?4JIg7qXKY1FlzNI7qCyujypEWmOemC6hI1tf4MVCDeRTxpkBzzoAeMcdxvue?=
 =?us-ascii?Q?4q1jGnZNTFA7QR5VXErww7DHzeZlLXjAzD1WnTbMl5fc82yhMVF6zojL3dVZ?=
 =?us-ascii?Q?wXU2T57MsAeJuH0EsF5nGdVuNdEjFjqP1hVOg9caYoE7ENHO5RG7Cx7PinNv?=
 =?us-ascii?Q?OBKNYqz/8TCh3ULkQEh5DEODTCgtzn4Dnxc9S3W2oCrNXZ9hLF2eROQ=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 4hp+o5i/xtPqn6Bm0NW+4GC3ShIBYUHrVPWAJDXGcI+u5ECZ/h7DmWsU+TtOE+cIRyC0+Q0kA600bBJh8VI/cd5BCJluOjmQr/TivJDh8E/RtNMrNuCKjOOU2E4GOgAIWSxB+iTHqUnV8sZ0zJhYeWWvuV/YiuVQy6aFt91Dwrg7FGFiwi3IW+qCniXf9q9u
X-Microsoft-Exchange-Diagnostics: 1;PN1PR0101MB1310;6:qivjOm6PS7WZ8A8I2Ns8i1pU9ZZ23tu7z/1sb/5mEa1Szwh7ol/Fcjgy7/UO6bZifj4cXLzPaM5Q8bZT8uTNTsyoJ83KG6TP1FnhZeS0XWhMvSXfLHVZ5Ip2LcJV2HVWlj6f4PE0Ajozb87WAkHTudXyjG/otLAP4KqRkP1px9VGRUFo+ENbQ1sQxMv67/9uV5ybAHnJLCxTwW//UFPVATp7AGzxF/3HRY3zJ+OmNBFYNXS/+LPxxWWEhYT6A2IHtho7YCk+ggozZ2F6UDuUWwinohnAmiFQvSRelPbsMNNbEg2magcsAsQEflpwKl/gNXgggy4rgHnbud6EUctX7rnfNU0wu2zBZpsP2aVVX/E=;5:IJsxuJWzlA1vhHmlWFNSIYnTZQvXu8QI3JzTwSe3b8oy28Cry9RjCKBkT/swfjGfXqo4egxa00e/fh+CoqvIkw8QdLbsqCcFXNwYM/sfsjuhxRv7HWmAKPuCbENBg51rB2XqeUCoydcLCl0We5UWIrItqUVSXfQlKUMMJGyCxNQ=;24:y5tYyr3lLqZYd+yN0Qwxihe/Hlir10qced1TZ01J1fQydAhkDWUIpVsnRs2PWOLl1To/MWMifd1dffkdnvnqy6No8OixwCS0eCrTkWRV5xk=;7:U/u+lu9yADnZy3GvWnrL2g//6X9gVil3UiNjY0qoQff9pPTc+wyfUpuVlItF05mtYPiVO/MSJ5N+cu/yiWZedmShUdE8ACvwffhZj4mmXSmy3PvBgrXPiZLsIScf+8jUj56YIchHgdbL3nNARfldYgCblPFoMUJSNzbp7Tzptoqg+jCFZS8p2Gu+w/F3T9MtMBsdRUpsYq9M7Vl7LC1qOCxU8VQoZ2lWHGRJ9zYwJ3WqYgkYv/jjP0bzLVdd3gfc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: softnautics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 05:34:42.3296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85773643-a03a-4c48-3288-08d58eed7333
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 17b76cff-50c6-4f7a-9198-dd4afc5f8bea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PR0101MB1310
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595524238464606092?=
X-GMAIL-MSGID: =?utf-8?q?1595524238464606092?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Resolved checkpatch warning "sizeof t should be sizeof(t)"
issue found by checkpatch.

Signed-off-by: Devang Panchal <devang.panchal@softnautics.com>
---
 drivers/misc/eeprom/at25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 9282ffd..6a7d4a2 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -102,7 +102,7 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	}
 
 	spi_message_init(&m);
-	memset(t, 0, sizeof t);
+	memset(t, 0, sizeof(t));
 
 	t[0].tx_buf = command;
 	t[0].len = at25->addrlen + 1;
-- 
1.9.1
