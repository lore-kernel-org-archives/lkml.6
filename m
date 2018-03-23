Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1536617-1521818643-2-316951779060503833
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAD_ENC_HEADER 0.001, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521818643; b=fJs9djbON7Pf3PDJR3THu8R+qr/7upuwTWbzTLXDJrd229a
    mCnfdaAIVeW99JaCDqIq2lqPZu+Qmtq2Ybxl5AQVa3sucEeT5+TMbFLfy6bb6TIX
    FSu26eGckkvnbyJqmOUKi8PkyBgZ0IHDqVZz3vh8V3sDx8H241frp1yIr+6x8bvl
    MfGwFjm+90aR8Mrm5VRigYPbymR/inPrWKhTIXz2Dz0uAQm6k84zEuusZB2OStEd
    Yd7eJS7Y2OhCYMdSGn45G/XzmAB7QgUw325oWekPJkHVK13F40PJPr263Ky09rKv
    ueyNdCUqJUIvpctBBC49g+sFRUhN1H+i79HqZ3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521818643; bh=q
    x04kVxDjsDt+KIXC2yK1MKwk8JIkX3J6R9rmliB6LI=; b=i8aFC3Oz+tAVaPvGO
    q/CPfNleGlczwfYKHm+aPcoO6edx3rJYc0SURIAlnV11HMkWnyB5U+JnKnG3WzBS
    Zbu6NABfJiZfKYfT/q/tHVeB+mJwrSijr4pGUjjcu5Keqo2ZpYsX6a5lSaglsTQQ
    X5+VoJvN0L+4oja0Znvz9hP1ILMyq7ow9Cyj9hh090tZOVaoB4u7gxwqwcO0t3TK
    EuDSAsT8y0ZcTQ7rsI7sJCyrejkoigJbz95vKcOXMfm9yvPx382HSsa6Li6SpkjA
    /ed2S4n/dUMrjLZLp5sTV1HStuxNk30R9ITbLNBtGoMZ6Y1suBBOwV0HX0qEtJ2Y
    GlqVQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=e+/ZFhuZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=e+/ZFhuZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com;
From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: fsl-dpaa2/eth: Use debug level for message
Date: Fri, 23 Mar 2018 10:23:36 -0500
Message-Id: <20180323152336.11946-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: DM5PR2001CA0005.namprd20.prod.outlook.com
 (2603:10b6:4:16::15) To HE1PR0402MB2700.eurprd04.prod.outlook.com
 (2603:10a6:3:e0::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b717ef2e-536c-47e5-e97c-08d590d21574
X-Microsoft-Antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR0402MB2700;
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2700;
 3:zJ8c0DSBFFFwoacCMQo4ILsAJrwdXdoHaFXL7nRCyXHZPvxUfcKUxTMmUUfFko0PG9Xs4Bd91KVlbMlAhEUM6AYaMHlxk+vkCmysafevHlBa+fHy8Qc3UTmLeCsw4tE2m4+saNQqxOcqIBMCfD2A1AbB5lduNYkMBWz3Wlo0hJjs7CZ9P6aW+1jDNN0nASitTVYng/T/yhMr+Es7x3TM0z5QXuNjS9Rl42X5UjtikwIyzlZFBaQDaai+C4lT6rM2;
 25:tmUh4S9XOyzsGesyLeqzKg7r1Se+j2l+A5Aa8JYW/uDsC7W7TqPMviQWoVpR7r/aeVX2nezuCgzw/6jw4PPIupkHvS0K9lkvtzQcAw2c2MuPDoAdhc+A3pj/n2FdpkFEC1FAyIs85mr8gST/IQNFqhCGR6PRkd0tkCzis9KU+b20hCGWSbABd738htGR/c1RIOqX7Z0PqFP6HoOvdHBYcfK4UfZoTvRwbXapw02hOk+VG3QQiS0Wmk4FHmbeHzvJYOB0nYyxt7FjyFPjz+qOuhrpGZs2iTkqG091qWpavmT0mDfB+KEInQ9+LvPu/xALBaiwQGIh5O2FeHv9dbcAnw==;
 31:zA5jEUI8+bFtjhSkDFqfxVi8m+lSyuX6H7lhDaJ++LGRj8/NfOqWLxsG2XddNxsINWOQs7+DWzrFQ/wiD0ZQqmtckaJMegpjxqr2qhhHl6AWIhF+PXniOHnCKN0ncYlCC7Z3gGvV4lH/yRdPv9MBhsCZfwBJFG2oD0nEjfUIyyrlDxHDmIohtCHRz3ZlBpYg1QQEo3wDpQQaCr/wjkw7NMYWN9S0pSwljJAJBNZZxTU=
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2700:
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2700;
 20:/h6oZ13cFZ/cgoAB0OxV119YN65PZFhkRGEQceNkSwxEjo/y1olZp9iir4WYeK+yv6QsBn9yh1S1i8aSk3NYbDQUrd/iWwn3Jzn0XlYXSeACe9K8IYfa62As9btOQA5JnoSo46OK1rjfyY+bt+eAHCihUk3E3tL2hodGWyo+XBvsqXQFIdCSt9jOD0qYRIq3m7Dl5qVKAtuoAyVNbEwIoEZul//aI9VNDtQvmRhpR5blVwA740NaSIYZ/ciIr7/x/xIqjympyK97ABxjfrhl+0W4vhYxFOincX9kaYjXuBf85GlT42VA7praUdX/qf43WL2JwpzXYq4fx4SEBrDE4ueIPE4sqB3/DfdJcFXDee1SN63405rMkr+aEc71cao837GwtGNxVYjrbSUNjAjI6lTcRc53AietTbEGQ/crAGcXxla1h6MIIJX7CDimD9o6vloDGazwbgmaUAxgwDJJ/9olpxYd6Td3C4skTYEXEGXsm2RNaJ0ocn0CT756oRXI;
 4:wsEsJ2Qe1YSqQo2GPrIEeF1DJvCYM1fDLG8iodC6dQc4t3d1xy5OIt6+tfeGVyTiAW2JnQ4xPGXgu0m27UE+PCS/H1LiZlSP4026+0NYnhtFMmkj7bfAAESVm/sXJRupKmdY64KlBWm7AQjuAOfxf0ems9CzSz1rrSIkgKxYaGI0aC8u7oM2pg1Ve6g5x64JrYOKe4XCV7HUIg+cnyD3xWXbyfusQXXzOdjpPd2L1Igdaz9pzRR7s7MAwA4YNz/B5hVfj+PvnpP7AbGTZgW9Cq631ntHJzn0jI0J7ziNBs5+lPsLKWwcJPe02Mmy6DQU
X-Microsoft-Antispam-PRVS: <HE1PR0402MB27006ACD893860083E8CEE2E94A80@HE1PR0402MB2700.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);
 SRVR:HE1PR0402MB2700; BCL:0; PCL:0; RULEID:; SRVR:HE1PR0402MB2700;
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(366004)(376002)(396003)(346002)(39860400002)(39380400002)(189003)(199004)(53936002)(6666003)(15650500001)(105586002)(68736007)(8936002)(7736002)(66066001)(106356001)(5660300001)(1076002)(3846002)(59450400001)(50226002)(50466002)(6116002)(2351001)(6916009)(305945005)(2361001)(26005)(186003)(97736004)(16586007)(478600001)(48376002)(2906002)(86362001)(8676002)(81166006)(47776003)(25786009)(16526019)(1857600001)(4326008)(81156014)(6486002)(386003)(6512007)(316002)(6506007)(36756003)(51416003)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0402MB2700; H:rhuath.am.freescale.net;
 FPR:; SPF:None; PTR:InfoNoRecords; MX:1; A:1; LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; HE1PR0402MB2700;
 23:tYrZeTYJwewR1mWaWKNAhP9kQF8JqKOytniQrq+?=
 =?us-ascii?Q?4Pgmhd4IUxNEvNixS3N5ZlUt8qIz/5QP20xkK3cHSEIl1fgfURcStEW22zbX?=
 =?us-ascii?Q?jDXnxyhC8180mMYfNSFWvAq0tUwOQcUHcVxKD5/Gv016RDuLceT6Ye2NGzz8?=
 =?us-ascii?Q?6o6l2RWU0KFXyMGoGiaq5pEZJhM/Dgc+8xUaO54OzA5siHxrkj3nJfEojoFf?=
 =?us-ascii?Q?7pCMzjNQSuo8tHxXpJi/A1a0wMQPftpZNJ38q9pUtzeiQNZnC+IzkGDTy84Z?=
 =?us-ascii?Q?I/mm9bxylCNvXhOsmnNwAtwUlxsZ+4a10OYY5SndH+algQboLSXHV2ThPjmI?=
 =?us-ascii?Q?BtmhRrKKFojkQFj4ibzlgrnnmXNVFsHHr4S2l/68isNEBOFhyKNLu3LbI7AB?=
 =?us-ascii?Q?8eVoBbiTUw72nNT1lXeK8Vh5+LLEZDVpE7T10GbKjoAYFwNYEtQYIVFp3L42?=
 =?us-ascii?Q?IzH8+3K5+cmBNmTdlJmWWw/zOMBjZBM6oP6YWoLtgw3cTQ3g7jDMFtzQDcO4?=
 =?us-ascii?Q?z5/ccWoEXp0gbe163EXB54ZHnidBKY0z1rd1ftAwH/4GN4X+reWrtSeRZrRg?=
 =?us-ascii?Q?xMrG8O8hyh0ktpdewxrn5nInpU0wBg0aPP4+ZuxPSZX/Fc2v1blnnpuExa+F?=
 =?us-ascii?Q?WZLNAX27YjVJ79dH0i93H+fTqRDh39+E7TTntv0tFjHyZ8JI8to5OlfcI+tn?=
 =?us-ascii?Q?ljgp2PDPArN3QP6mFyL/ojbigu8JGN6Ft/jQ13HOHxlnMq5FlHpaWUlWhxs0?=
 =?us-ascii?Q?fQTqykf9oMrdrT2IpyK7/PT4aBOBqHpZhrgzYVpSnakrMowxn6lvHzJNBwQp?=
 =?us-ascii?Q?HnUV0hiJwDGtrfLjut3yDCa/wNLLfqEDBQUmQvGJiIcvAtIXWGECGUeQRcOi?=
 =?us-ascii?Q?lDvTAr9KbjYL4eT8L7qbsAhKk/6u4NeTOSOktq0Z7RrArunHZ1RYsEg/VjAJ?=
 =?us-ascii?Q?pvJwphi0lZ6VVZihSnL53GTYaqUawmgGxyguDmj3CNBR0BI2Fz7v+Bm5rDjq?=
 =?us-ascii?Q?mJyOUju1Z00yB+CpwPY5KLK90dqf+EIQix+gtsBHyfozl/7AjQfByHpqZ0xV?=
 =?us-ascii?Q?076yh89xYLaHKQJICzXEM+vStx/HP11azDdcuzDOMlr+3Ra2qRhbXGThEy+Z?=
 =?us-ascii?Q?OCsid43+oXSO73/1sjV07d/ZpXSQKVPSV3/Eb7stD0endrvTuZhZxdvzPasj?=
 =?us-ascii?Q?ETOQuDTPejcV7dK0=3D?=
X-Microsoft-Antispam-Message-Info: Za/G9aL1hSYqowscwjxBgT0QJZCHccyf9sMm1l2qHjS6Fm35vIv6f2Mm7qeaL6U81Cmmu9nYOLAWQnK+OKYJmV7ZKtcdQT5076IkCTlicD2UT1MR1pTRM+xP4IlBtpQEX3mu+zfT2QP11TzbvVDnwOS2Tbw1WXuy8Kzz6VcmhJVs1Sb/eIfix7veM/+fxz0H
X-Microsoft-Exchange-Diagnostics: 1; HE1PR0402MB2700;
 6:BUsHl9+OpNCmhCV62qKpF2YE81JICmWAW/5G5tJXgN44nsWoTiEbNmn0kywRHkqrf7rRYtm0AFwFD3afkUGvMlfp4fu8+OOB9Qw9lbI/glzzxisiavfisRlnNtLSekf/PX7MG8NIZ2180BTGVgozIn/FFwvjQetjCjCxh1iEcdJMZ6xNQCzzONSDDLnbm6GhN13/dx827hzeDpZx/4CopsTbxWeKGm6B4NRDUink33fZb8zzR9q0ccUSKanSN+vmx9mXIOd0d5U4sRTdU3ecIGmvSYGpmHqv55T5u4yFjnZrjihRCrXvF/4Futyjrdm8AxvkrdASkI5SDKpY91oxQwNZgjFz2leV9FKU5kolmw4=;
 5:FIqOmrqQNZdx0u/KPQnpUVwKj3QVqd4aQdNzhTCXlJ++tUhqQy+Zh52rxentLWqDjSA9S7Gh1VfFjcn4gg9FMRqKcSrfz5JxhExWJifryCE/4Al0c0vJyj/81xwm9slvOVcJIADQF9axtnJeG9RKfl/jZdc8VJvQEqrPu/n4VoQ=;
 24:8Eb9tdIijTLDNWw3DPSm6IABSvtM018LTjo7plDcD7C8/NPJf1+4iqZ4DKPybcXxCxAARjmXHsCAO5fho9RWak28m2VuYX9xwYJXySO7SJ8=;
 7:Z4EoYX9vhijZ8bmwA15SQcetGsnNeJ8Iae9eiEBoieJz9Zs+gxn/5ieTk0bjqXbX2tyHRPAsVtTd8wpTVB8SJO7bY2cjajh/6RtVHJfuuJ2L4NcX5HZYdtr/cvCQqTn1DBuV3U8pCC3M3JF8wSRPYfaUvJ4u+G04ub+ewMjdTyG60wERYj4gc58W2zL7sT1ZHFqGTwn8oavOYP6JApo2TIyHUTnFGJMUNVjhpG+hwuV5ZM4duefe1+PuKwiVEMfG
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 15:23:50.8589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b717ef2e-536c-47e5-e97c-08d590d21574
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2700
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The driver remove() function prints a message when the operation
is completed. Make this a debug level message to avoid polluting
the kernel log wih too much information.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 14bd8fe..553678d 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2578,7 +2578,7 @@ static int dpaa2_eth_remove(struct fsl_mc_device *ls_dev)
 	dev_set_drvdata(dev, NULL);
 	free_netdev(net_dev);
 
-	dev_info(net_dev->dev.parent, "Removed interface %s\n", net_dev->name);
+	dev_dbg(net_dev->dev.parent, "Removed interface %s\n", net_dev->name);
 
 	return 0;
 }
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
