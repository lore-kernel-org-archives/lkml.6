Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757267AbeDZWfR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:35:17 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757152AbeDZWcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:55 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 16/24] drm/bridge: ti-tfp410: provide an .owner device
Date: Fri, 27 Apr 2018 00:31:31 +0200
Message-Id: <20180426223139.16740-17-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:U7AI7vdwm2FVH12tLtiKYFYPOyv+za+ecqYZySkdI45tZNaeCyofZ/mtGc3sxTaqE0jlnqoU2jJoWZLswBUy3f2c2LGUxbXtrKKGXtWU2IJvr0kew5Bh8rn2nNfpV0leovGhk/RkzXvfqdeyuXyJRt1vSEc1+ipjCSJHyWBtaqmc+Dbv01bFOXE6A5Z34IPEH8WL4T229QgMr7u7FNE+rDd+KgX58I3WJZsW8GYXLoUPm/pkUVVrsYhg97gULEiv;25:rOBhasNVkF12kCw7PY01NlW4fxjlxW7jk9tn0BsHONgNmoYuRR2heOdimcOZzzyk/RH9kQV/BUG4Zy4nAYb9xBWFkAxEItJ2i9NAiXtY5BLNpFGTe1rClng3DPiGFbixXoVEVMpZCIlMIahAFGYjgMquBqOc0qW2gYsiFrisuGvbj/T5MM8/7OdLYnW0w8H4muOB1P+yiC7M65Csx4wc/6HpCh5CJIIJJKg8363To6kdLZNr6n++2vQVva3cGZTYbNILJ4EWD00ZlX6KR3DqD6hJmdvbxEqKQ9kXYLnYzjEUynrhD0HkBO1vHnFvpSmF/TFFlR4RlgTrrj1QieRO2w==;31:MTQYkXkHodgyHEQPuRSImeeb0SjfQzHtKJmrocmnMiG66CPOHLTrm7rS1BRNGirhx+zklzp18San2S6E1G13tOuMwrozooVJpK5Xz8oBE6izUYICSDZxJOXW7ibVCM/J8QVQpaslKoMZytxGYXhvhbmweOvYH0CdvnN6yL7TJKe9IoCcS6GCW6ycpMyPbXLtKXSwo+bUUni2C54O7t0reOdn/Hpr/iq94Ra/U/ytl7I=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782DFD85EEC864B462D3ED3BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:TXchNmLyG4F9zjtUUb1t6WOdKXJPvU73nfiozSCXJ5vjfw6rTF6TjnjlepBTt2YBK2XWiJtMRhEX26hj3sdIGXnY7n7pCI+28zhW02cLgiO6UaBSQFbpxdO6oZ8yOyf1NYaojt4lrW6FO7da3zHLzpxGeHY8GsS2+M+I8B6g5bKLV6CsRpgkHr3EGVNLnIzCXXGG9rOG+1l91DR1wxD8yZC/r+tL72Inh3Sgqd3arUvLX8xSc7KpELLDCgyGIc0XGlBXQK0k5HjAV28ZxAHJwA==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(50466002)(4326008)(476003)(59450400001)(2616005)(86362001)(956004)(8676002)(76176011)(26005)(6512007)(486006)(6506007)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:IRXflpU/jyMp4ZNQxcrn3319cGxJ+EVMggaTe8L?=
 =?us-ascii?Q?jXmEq3TUR+nMI1kDJafZqSgrQ2UtdhrtHZgoT+enPgfrz6lGE7uQ98Nv3mRh?=
 =?us-ascii?Q?blYPhDilUIDXGtsVV45zvR/BofYhrVIZUyXGRmf19/59dKxfF6/X8l9ZoPF8?=
 =?us-ascii?Q?VM/NIDsXOKh6qsnuZ9BLTgkiHdKgYvn5pLpHcVrLjBi7Nml9vI/0hlUBR0Vi?=
 =?us-ascii?Q?dwRE3nVeeY5Ym4W7w/yKttKMhTwX02ORC3IJZwyn+ohiETaJsTi7leN/F+Cu?=
 =?us-ascii?Q?mMuqWKqDsM2hXyD7AADGec0VgCSliQ7R6GhWilCmAhbghwtx3izPUulMM2Sx?=
 =?us-ascii?Q?RnzCm8MpD6wZo4ViEcPz3lA/dLI3wNTdknmLxlLp39BBxBqrHH6XGCKjvGP9?=
 =?us-ascii?Q?0C0oSXriVIFWzXqVoF95flS6yT2DHb40svOtqfZ7Buxj9SR4M0azncCZvnmr?=
 =?us-ascii?Q?ZgdIzPZR5riA/bOotzrSMAnxAGx2IWPmYVSCz4q/eZyh30ELzZDQGiLJUB2l?=
 =?us-ascii?Q?DossWETxK2tafOcdMCUWcbePYKH5YwzNBKxFkKAQ0/IupZELqjdLcCrMA15b?=
 =?us-ascii?Q?QI7sGgPQqrPB1o7F5oLfnU36febVbYQgjPRZajwXBVsZiCyZTU7uYG/GSRZk?=
 =?us-ascii?Q?yCbaby2pb0HN3NMR6WpiAPFeKcQE4BkrCclLkqeKIo/UtIz+lHw0DgboxjJN?=
 =?us-ascii?Q?jenQb+ai8EGTf0sjhG7Pz/UBoStQ1tr3fsCyJ5uN9U6JWc4sgGCquQI4bBGW?=
 =?us-ascii?Q?k6LCskF3+fof/sqxGRdzlVr0r60XODqrjEFSgXvST8UWZSzk75fJ+c1OI+Lt?=
 =?us-ascii?Q?yKc+ldNmbbQz1+6uHzYWcaRuA73aRUv0C+QAbT2L4+uN32aUFSf3ab2ZOz7b?=
 =?us-ascii?Q?uvWOvIODDVNBkrAXwbPEPRHuQZJB2fL4Qd5NnNW0QTOIb58DMsdNqDsrHJ1t?=
 =?us-ascii?Q?9mUnkB/9O9wch6kSfmtvk9psUfrHiGJX7cnRDQXOzGH0nLqCsn+faYNt8iyr?=
 =?us-ascii?Q?mzf16lNIccj5xalZkz+ZFx/kw26JBhUL3N7o776dh3wxhFhXc7fBNNjsFEdR?=
 =?us-ascii?Q?t+D/LTAcGxFGDwif8JE6aZT656oO90tV/PFMP+J3yT09/J9RUSQwKGRIz/1e?=
 =?us-ascii?Q?MWUAVucxPRhL+A7iZtLS5E9FzfToFmo1yS5Gax4INZXc/YNxUBaCixNlyg8I?=
 =?us-ascii?Q?s0uW/K0OOHpathSCq4OZ1udubSGx5ZT77aCYpRJ8/WDe4j7jrITCBnx2jfpA?=
 =?us-ascii?Q?ocN1NHdHXCvEdB/u8DiBTQN3Y/5/Z6Bac9JhLDz0WGkncLVtYtfoN8LRWJNK?=
 =?us-ascii?Q?OCWL66K+2sIBjML7PYqQLItC3p/3xrjvOUzpGhbxnPXWme5VWFRLCiozULop?=
 =?us-ascii?Q?Y5sJ+JJqnh8FFbw3ZHI7uwnCQT01pE0iYO/6ea4c6osflRKrKfuwM5ZicBnW?=
 =?us-ascii?Q?WmuaTJswFovRMCGluOEb4spQsQOIzbrs=3D?=
X-Microsoft-Antispam-Message-Info: /UbvavefO42BPUXaOxWjI838YDwPvAUTGMG5g32us3JiL6N+NxhX/AYRfQVY3JuqJ4kfM278q68Xp1q2XYMRVmguDKbsuBAnp3lTTGSH2t4NE27VWt8P3Mwl00x93lMLSGYr3xF4rYN2bzhnZqPEeMNRxOG/xV02Pgq/nqysm29Q4O++e4z2B6NCIHCE4n7L
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:GZWbT2PM5SbnU9zderNrHYqFwOZQjoYSDrtrQHeZVAnLqF5NSZ5KA364VGLDm8S162GAwYhkC827VhWhOTUtpWUKjbNy0D3MRhxQ62dSIexekUMwTJvWqXW6KQ/Avya8eluhOM/i+NjInkdMJT8pl9lgoOXt0sZuz1xprFXBg+rtwvD0g3IQGDKdfJQFYAZCyrm8VBVZjLUFjblqLdti85SwlqNQFQ24GrutP/unJKARU04uwE1tnQwgtYsjtDxa9PTyl4YWQTbez2f1220se96ZyvfvhXs84zEXan712q53qjq50rtCOvY27nKZspicfpik+nhqZaUUax3N/02q4afoCSZqe5fY8C1Gs9Bie3ft1vCaaUFowkt79luBNdOof/R7PtnhfVNKS9M295ogBh0BD66XZvlOdWBp8hYD9G6ZhvRqWK/Zqi0b5Tz4cTDqcLMMqUj1OdVbKh/QFFokWQ==;5:zuqOjTENuxiKS6alBovtFo1jEB7Hka0FJs7CM62+rYtUQsr84zFD/padai0AKoNRcnkPKQFAtrNrrsiKID0FQ76PF+PolAZSh4mieAaWZuhg966nsuLiRNKGyRZHIqSQO7LpwcskuFFH9xcLiz18YJDPPhq6JMFB3kWEz/iwGGk=;24:MzB3K6yJz+kPcLGqgdhh7WM1fYDXBMte0wwn7qS5i3b5k6gfomOe/VRonqAxyqwt0MCXLRI2rDIoIYU8s5sQM+8hZVlrJgfq8YE5TI2iXz8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:aM8h7TmLRd+D8Bdhy7aP3C+QfGfUbon8DWw9Dx7Ok6WqpWP9BYWW1HXfPqJe4VrLRfYv/0Csn76in+5D+r6QjxZ4uTf4RJ8wpQAj7vUlUrch3mj+rx8A3DrwUaeRjnwP3r/0yqm5gPul/6XNNnOXHfJ4ryDmKowC4BSOvb9ArEXZBCsZNwt1q3t4YEdw2IJ1470nlFL3c63MNVpmZLfHwMqr0tl78unsFvyeIQNpOyboDN4U7S4ZOrRqrW8Nw2lj
X-MS-Office365-Filtering-Correlation-Id: f6bdd740-25e7-45ea-2959-08d5abc5a226
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:45.3078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bdd740-25e7-45ea-2959-08d5abc5a226
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index acb857030951..7e5938e988be 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -215,8 +215,8 @@ static int tfp410_init(struct device *dev)
 		return -ENOMEM;
 	dev_set_drvdata(dev, dvi);
 
+	dvi->bridge.owner = dev;
 	dvi->bridge.funcs = &tfp410_bridge_funcs;
-	dvi->bridge.of_node = dev->of_node;
 	dvi->dev = dev;
 
 	ret = tfp410_get_connector_properties(dvi);
-- 
2.11.0
