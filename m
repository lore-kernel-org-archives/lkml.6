Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0831C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5827521916
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="TTBBxGe7";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KF/PYqX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437328AbfBNTqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:46:44 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:57420 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436519AbfBNTqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:46:30 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EJgug5020708;
        Thu, 14 Feb 2019 11:46:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=3gOesdJgOTx1waRetlX1lT5bnmyRu1vCBsZ2lcnjiIM=;
 b=TTBBxGe7kftUlXSQnWcnH58lg7QPBP9jqUB/o7dUHElcsHhfAqgxgNlBpK705IXc25kf
 ReG//NHnkjPyARowUSbOeSIZAv/DYL0FX3fsygXe1EqETGWuTxEnB6VFpcbXFyO5Zkuf
 msV2I9eiWShricWmDvFJrj7eS1mG/LOL/bpclK/Iq+GtPjl14yeC3CdRjRyuTU23FdUX
 Hxms4cQUJsuuAXhUbT/GPCyHxf4Z8B4ipIW9K6hRMYlTIsAo/vFiFjGuWE+oWOE4qtva
 O0sgZg1PEZmmaX21q0oIV2dojMVm6c0yJHz+OcfLAe9ZsHjXEJZWm59gxQ9PLHmEGkV+ VQ== 
Authentication-Results: cadence.com;
        spf=pass smtp.mailfrom=pawell@cadence.com
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2057.outbound.protection.outlook.com [104.47.34.57])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2qmt3v4vpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Feb 2019 11:46:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gOesdJgOTx1waRetlX1lT5bnmyRu1vCBsZ2lcnjiIM=;
 b=KF/PYqX4SBYJBU4TOcWAOwh6995KKHx7JKt0n/z6yLUsxWcBbeAr/O6BMDoGjlrRqypwEDE+e06J+wYV1leFGE2jprHlptesMGyBVJwlDYJbxTd8yPHCT4e6u3fhxP5Ch/s9oPmwg2Gz2Vvfsgj/+EAcA0dBUh88jdpze/gTVkI=
Received: from BYAPR07CA0051.namprd07.prod.outlook.com (2603:10b6:a03:60::28)
 by CY1PR07MB2248.namprd07.prod.outlook.com (2a01:111:e400:5a10::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1622.16; Thu, 14 Feb
 2019 19:46:09 +0000
Received: from CO1NAM05FT020.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::208) by BYAPR07CA0051.outlook.office365.com
 (2603:10b6:a03:60::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1622.16 via Frontend
 Transport; Thu, 14 Feb 2019 19:46:09 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT020.mail.protection.outlook.com (10.152.96.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.2 via Frontend Transport; Thu, 14 Feb 2019 19:46:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk2cW012765
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Feb 2019 11:46:07 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 14 Feb 2019 20:46:02 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 14 Feb 2019 20:46:02 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x1EJk38M031479;
        Thu, 14 Feb 2019 19:46:03 GMT
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x1EJk3ta031477;
        Thu, 14 Feb 2019 19:46:03 GMT
From:   Pawel Laszczak <pawell@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <felipe.balbi@linux.intel.com>,
        <mark.rutland@arm.com>, <linux-usb@vger.kernel.org>,
        <hdegoede@redhat.com>, <heikki.krogerus@linux.intel.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>, <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <jbergsagel@ti.com>,
        <nsekhar@ti.com>, <nm@ti.com>, <sureshp@cadence.com>,
        <peter.chen@nxp.com>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 6/6] usb:cdns3 Fix for stuck packets in on-chip OUT buffer.
Date:   Thu, 14 Feb 2019 19:45:14 +0000
Message-ID: <1550173514-23573-7-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1550173514-23573-1-git-send-email-pawell@cadence.com>
References: <1550173514-23573-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(189003)(199004)(36092001)(87636003)(26005)(16586007)(6916009)(186003)(2351001)(14444005)(316002)(107886003)(486006)(106466001)(336012)(42186006)(476003)(2616005)(36756003)(11346002)(105596002)(4326008)(126002)(4720700003)(446003)(426003)(478600001)(7636002)(51416003)(26826003)(47776003)(305945005)(76176011)(30864003)(48376002)(7416002)(246002)(50466002)(2906002)(6666004)(356004)(54906003)(8936002)(50226002)(86362001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2248;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT020;1:51wsYKFgXH9AX++Jyt15tY09hFZVqBmsxeQXu8byDShOyaGtebV5UF5sIWpqE5mN/6zg1tFstrhdu6Y4rCp3P5eZEVckx+m6POqAr8NRP46o9V+O1s52btSWq6oiPU2FrknrT28dmoSZwa9OiMnJO3OgZLFL07J5I88pbFKyoA8=
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cdbe357-b669-4fef-cbe7-08d692b510f7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060);SRVR:CY1PR07MB2248;
X-MS-TrafficTypeDiagnostic: CY1PR07MB2248:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2248;20:Q+n6cqEajQFWKS6MZA7sCgQE8DC9YKgiKscU6aX/Wkg7hYPDUa7ieuxEaOeyaEAd5L9UNvX6iH+gJe+MhLyYgHluyPby5TsjRyfWP1+oH8VPva3bcIlYPBag9/eAiyuyPh2G2n0o0tOJxEDZkINK7pqs2Lj85mxHbASHumTkY82JV60CM+MVMrot5yKfhk0QxyTdfLyivJNXKYDwE2/NZrGPzfBEqkJcsy3XtPQqFjy8LZUrtDRTfZqoZbp8snvw3wvZRtBT5PLv+mwWnXmQBUFXY1JZuoqzgh6OVT8tF0UfgMzbMEosDFn0pqyS7ox62UYwk0f+aVKVT4j2JzAGTbL3FNdqV4XDEDeRSbdeZyd1T/1rfbLx4amYpR3y1mJAlCotwM2ni8zUt7jLgawe/ug2z/q5+NHtg7O0jPZ1P7vNvKJ4/is9m7nhgun/47PGJ8xdB6pn5wGG7FepE/YgeODMcNcmr49mUSNnVnytXjoYAJTBcbEs/TcHn4GUbdti
X-Microsoft-Antispam-PRVS: <CY1PR07MB2248EE2E203904E6CBE259C7DD670@CY1PR07MB2248.namprd07.prod.outlook.com>
X-Forefront-PRVS: 09480768F8
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2248;23:dQFh/Wd0utzTqxYzQfxJtRCJG4NTfDTTpQLfDh/PF?=
 =?us-ascii?Q?j+sYIiZUXwIibnxhS5hMUrgeg5wjUvjj1NK5vnoTXmVu5NSbA0/TzELNAuzQ?=
 =?us-ascii?Q?auxwwiSnzSkDIM2OPROOeVI79Hi3LQ4cPqPvhhQTsGMgQRWGdgDkuI23aLeP?=
 =?us-ascii?Q?2ywWtrm8OueW6dwIuSPtRhEQvlCtx7m5c0gSMkG7YAS51B/tVvFnSzWlISBa?=
 =?us-ascii?Q?ZLpFyvPUFJYH6yWxByAP02RxehIn0iH+9Cqdjjb2+kIBkvWSsq+kuMXVqWZS?=
 =?us-ascii?Q?kcLqgDDNm27JQsTdNAmhjSfJstgx73lMoahuykbioVF4ypYr4XuKm4jhNHr5?=
 =?us-ascii?Q?KEx+eYHtoLKWC9fS6DGE2kSqcpr702HzcNP3yb0GGrc5h9+4GxalQORjWnrm?=
 =?us-ascii?Q?WLkeORBmbpbS/VIRNvYM0tQs8kiNswcDdGs++UgCS/3ma9RFiy+gQ8fgdTtY?=
 =?us-ascii?Q?1tRZ44v3TSgTURmdk6p0lY0pQuDIaO+WA59Izn1MsG1OYKuvD2+1L3t/nIDr?=
 =?us-ascii?Q?au0opywa1OrvA477YbdwjP55ujckbO4HG4eBqzSOadyPmIU2yeEtSlhbl6LO?=
 =?us-ascii?Q?zLMudvrWZQX1WYV+vVF1rpdqv01QSppeilTBQkJARVvLMI5HkGh0DHl/R3w1?=
 =?us-ascii?Q?zVVKL14eKAWHEg+sVBirtWruY1CkpCawtXHuI1NAvSWYqU3Zvmd92X9Rf5HR?=
 =?us-ascii?Q?uJMNlomqvk9mPoplXed2pSHKSUzcyEukmKAeIZv4D2Yc3tCrtebWxuW6+lw/?=
 =?us-ascii?Q?7q7A/7UEGh8zV4ggiPKBtzOsXuPCys2IauMdsIGFvKTLfNAPnAufGZKsUMb5?=
 =?us-ascii?Q?Rdbjq7agOVnJjiLa1OVm2nny1ZXPss5nrmbdPoCl7vup+YbqSuVpDoPUX91i?=
 =?us-ascii?Q?Uyr0lSfVFv6WFULcgbk5mv4KCWc6e57VrNUdpLsFIGBSCWa3L7FmJ8NwI5am?=
 =?us-ascii?Q?MbdHnnOFm0Zv8vYt7r/ejLxQnclyv2qNpTDhIUSMXUrsN9qR15bOdRwMfLuB?=
 =?us-ascii?Q?NiIx30lEqIpFyqtA1ilfUn6nxvHL+9DeakBhSdJLUGVfu88WTAOUl4pekUE8?=
 =?us-ascii?Q?LJy4VqxqslLlSEEnLnYpd/cGuWL2onJo4Ir+6nVtk4CqpCmqPfae2IFXak50?=
 =?us-ascii?Q?UEKJf6mH9al8A+5IlddvhLwXxOm5H69?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: kt1hxvMKRCp5PX3ey2sDh40vSdBRq/7F0ciI7OC8NN8OvuhzWxYltkVLF+FEBGzAr6zmkDX4tXW17FKG8IfFxwUECSc5JWT9mYJfjTpXjFfd6rTfdRH1Wwi3WzE8eVl1x59EGHoFZe1ucJ8FSDpzKWjZAHCx6jU6uyFSgJUyzuA6zuFwVDPsh6n7oKh5zWIJpv8JKe9LY8oGcUGaNSh86Q9E6w9EvKR5uIfovLn1M2711bdecGpi2JLjrNYT/OzafX8/Oxo+KUObOIMNCHVMhkiFcQYGuyXFhgjGA0WvjXhMsIrMgXQtdI1row57Sic7SJ1SGT7+VGB2vF1NqYyRD2tGHfVPw/oUHOBQ0J+V9X9piCU36rD8XeqkKkRfiScGQY2Feqz8ShKfnYvmvqB/3FM+fm9DGROuOjtabph3EbY=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2248;20:nKgFdWWb5BvATAORzgz3eq4H/JyuRlVWm8pMpx7XBFlCnB1+PuOYcBe64DJSjB8Uk0zEFjM64BvfAj4/6nOax5RNL6EpKfYhxdzYcB0RQZEW8j+TEqy9LTUrRZ9tu3lYnH0YJBWnSZfI/KI/cIhh2OoWCh6ON3XSJCyD5UxBdBuRiXeaMuNmfHNFcYRetn2C2lbOnX1RO0O7PP6xqBHDBTEX/a5IEtIDHJ1xw+hOK7f+b6fTp66W5MIKJjdR9vHL
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2019 19:46:08.6100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdbe357-b669-4fef-cbe7-08d692b510f7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2248
X-Proofpoint-SPF-Result: pass
X-Proofpoint-SPF-Record: v=spf1 include:_spf.salesforce.com include:mktomail.com
 include:spf-0014ca01.pphosted.com include:spf.protection.outlook.com
 include:auth.msgapp.com include:spf.mandrillapp.com ~all
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=3
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.0.1-1810050000 definitions=main-1902140131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller for OUT endpoints has shared on-chip buffers for all incoming
packets, including ep0out. It's FIFO buffer, so packets must be handle
by DMA in correct order. If the first packet in the buffer will not be
handled, then the following packets directed for other endpoints and
functions will be blocked.

Additionally the packets directed to one endpoint can block entire on-chip
buffers. In this case transfer to other endpoints also will blocked.

To resolve this issue after raising the descriptor missing interrupt
driver prepares internal usb_request object and use it to arm DMA
transfer.

The problematic situation was observed in case when endpoint has
been enabled but no usb_request were queued. Driver try detects
such endpoints and will use this workaround only for these endpoint.

Driver use limited number of buffer. This number can be set by macro
CDNS_WA2_NUM_BUFFERS.

Such blocking situation was observed on ACM gadget. For this function
host send OUT data packet but ACM function is not prepared for
this packet. It's cause that buffer placed in on chip memory block
transfer to other endpoints.

It's limitation of controller but maybe this issues should be fixed in
function driver.

This work around can be disabled/enabled by means of quirk_internal_buffer
module parameter. By default feature is enabled. It can has impact to
transfer performance and in most case this feature can be disabled.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/gadget.c | 273 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/cdns3/gadget.h |   7 +
 2 files changed, 278 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 7f7f24ee3c4b..5dfbe6e1421c 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -27,6 +27,37 @@
  * If (((Dequeue Ptr (i.e. EP_TRADDR) == Enqueue Ptr-1) or
  *	(Dequeue Ptr (i.e. EP_TRADDR) == Enqueue Ptr))
  *		and (DRBL==1 and (not EP0)))
+ *
+ * Work around 2:
+ * Controller for OUT endpoints has shared on-chip buffers for all incoming
+ * packets, including ep0out. It's FIFO buffer, so packets must be handle by DMA
+ * in correct order. If the first packet in the buffer will not be handled,
+ * then the following packets directed for other endpoints and  functions
+ * will be blocked.
+ * Additionally the packets directed to one endpoint can block entire on-chip
+ * buffers. In this case transfer to other endpoints also will blocked.
+ *
+ * To resolve this issue after raising the descriptor missing interrupt
+ * driver prepares internal usb_request object and use it to arm DMA transfer.
+ *
+ * The problematic situation was observed in case when endpoint has been enabled
+ * but no usb_request were queued. Driver try detects such endpoints and will
+ * use this workaround only for these endpoint.
+ *
+ * Driver use limited number of buffer. This number can be set by macro
+ * CDNS_WA2_NUM_BUFFERS.
+ *
+ * Such blocking situation was observed on ACM gadget. For this function
+ * host send OUT data packet but ACM function is not prepared for this packet.
+ * It's cause that buffer placed in on chip memory block transfer to other
+ * endpoints.
+ *
+ * It's limitation of controller but maybe this issues should be fixed in
+ * function driver.
+ *
+ * This work around can be disabled/enabled by means of quirk_internal_buffer
+ * module parameter. By default feature is enabled. It can has impact to
+ * transfer performance and in most case this feature can be disabled.
  */
 
 #include <linux/dma-mapping.h>
@@ -42,6 +73,14 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 				   struct usb_request *request,
 				   gfp_t gfp_flags);
 
+/*
+ * Parameter allows to disable/enable handling of work around 2 feature.
+ * By default this value is enabled.
+ */
+static bool quirk_internal_buffer = 1;
+module_param(quirk_internal_buffer, bool, 0644);
+MODULE_PARM_DESC(quirk_internal_buffer, "Disable/enable WA2 algorithm");
+
 /**
  * cdns3_handshake - spin reading  until handshake completes or fails
  * @ptr: address of device controller register to be read
@@ -105,6 +144,17 @@ struct usb_request *cdns3_next_request(struct list_head *list)
 	return list_first_entry_or_null(list, struct usb_request, list);
 }
 
+/**
+ * cdns3_next_priv_request - returns next request from list
+ * @list: list containing requests
+ *
+ * Returns request or NULL if no requests in list
+ */
+struct cdns3_request *cdns3_next_priv_request(struct list_head *list)
+{
+	return list_first_entry_or_null(list, struct cdns3_request, list);
+}
+
 /**
  * select_ep - selects endpoint
  * @priv_dev:  extended gadget object
@@ -384,6 +434,53 @@ static int cdns3_start_all_request(struct cdns3_device *priv_dev,
 	return ret;
 }
 
+/**
+ * cdns3_descmiss_copy_data copy data from internal requests to request queued
+ * by class driver.
+ * @priv_ep: extended endpoint object
+ * @request: request object
+ */
+static void cdns3_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
+				     struct usb_request *request)
+{
+	struct usb_request *descmiss_req;
+	struct cdns3_request *descmiss_priv_req;
+
+	while (!list_empty(&priv_ep->descmiss_req_list)) {
+		int chunk_end;
+		int length;
+
+		descmiss_priv_req =
+			cdns3_next_priv_request(&priv_ep->descmiss_req_list);
+		descmiss_req = &descmiss_priv_req->request;
+
+		/* driver can't touch pending request */
+		if (descmiss_priv_req->flags & REQUEST_PENDING)
+			break;
+
+		chunk_end = descmiss_priv_req->flags & REQUEST_INTERNAL_CH;
+		length = request->actual + descmiss_req->actual;
+
+		if (length <= request->length) {
+			memcpy(&((u8 *)request->buf)[request->actual],
+			       descmiss_req->buf,
+			       descmiss_req->actual);
+			request->actual = length;
+		} else {
+			/* It should never occures */
+			request->status = -ENOMEM;
+		}
+
+		list_del_init(&descmiss_priv_req->list);
+
+		kfree(descmiss_req->buf);
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, descmiss_req);
+
+		if (!chunk_end)
+			break;
+	}
+}
+
 /**
  * cdns3_gadget_giveback - call struct usb_request's ->complete callback
  * @priv_ep: The endpoint to whom the request belongs to
@@ -412,6 +509,32 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 	priv_req->flags &= ~REQUEST_PENDING;
 	trace_cdns3_gadget_giveback(priv_req);
 
+	/* WA2: */
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN &&
+	    priv_req->flags & REQUEST_INTERNAL) {
+		struct usb_request *req;
+
+		req = cdns3_next_request(&priv_ep->deferred_req_list);
+		request = req;
+		priv_ep->descmis_req = NULL;
+
+		if (!req)
+			return;
+
+		cdns3_descmiss_copy_data(priv_ep, req);
+		if (!(priv_ep->flags & EP_QUIRK_END_TRANSFER) &&
+		    req->length != req->actual) {
+			/* wait for next part of transfer */
+			return;
+		}
+
+		if (req->status == -EINPROGRESS)
+			req->status = 0;
+
+		list_del_init(&req->list);
+		cdns3_start_all_request(priv_dev, priv_ep);
+	}
+
 	/* Start all not pending request */
 	if (priv_ep->flags & EP_RING_FULL)
 		cdns3_start_all_request(priv_dev, priv_ep);
@@ -774,6 +897,59 @@ void cdns3_rearm_transfer(struct cdns3_endpoint *priv_ep, u8 rearm)
 	}
 }
 
+/**
+ * cdns3_descmissing_packet - handles descriptor missing event.
+ * @priv_dev: extended gadget object
+ *
+ * This function is used only for WA2. For more information see Work around 2
+ * description.
+ */
+static int cdns3_descmissing_packet(struct cdns3_endpoint *priv_ep)
+{
+	struct cdns3_request *priv_req;
+	struct usb_request *request;
+
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
+		priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
+		priv_ep->flags |= EP_QUIRK_EXTRA_BUF_EN;
+	}
+
+	cdns3_dbg(priv_ep->cdns3_dev, "WA2: Description Missing detected\n");
+
+	request = cdns3_gadget_ep_alloc_request(&priv_ep->endpoint,
+						GFP_ATOMIC);
+	if (!request)
+		return -ENOMEM;
+
+	priv_req = to_cdns3_request(request);
+	priv_req->flags |= REQUEST_INTERNAL;
+
+	/* if this field is still assigned it indicate that transfer related
+	 * with this request has not been finished yet. Driver in this
+	 * case simply allocate next request and assign flag REQUEST_INTERNAL_CH
+	 * flag to previous one. It will indicate that current request is
+	 * part of the previous one.
+	 */
+	if (priv_ep->descmis_req)
+		priv_ep->descmis_req->flags |= REQUEST_INTERNAL_CH;
+
+	priv_req->request.buf = kzalloc(CDNS3_DESCMIS_BUF_SIZE,
+					GFP_ATOMIC);
+	if (!priv_req) {
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
+		return -ENOMEM;
+	}
+
+	priv_req->request.length = CDNS3_DESCMIS_BUF_SIZE;
+	priv_ep->descmis_req = priv_req;
+
+	__cdns3_gadget_ep_queue(&priv_ep->endpoint,
+				&priv_ep->descmis_req->request,
+				GFP_ATOMIC);
+
+	return 0;
+}
+
 /**
  * cdns3_check_ep_interrupt_proceed - Processes interrupt related to endpoint
  * @priv_ep: endpoint object
@@ -807,8 +983,31 @@ static int cdns3_check_ep_interrupt_proceed(struct cdns3_endpoint *priv_ep)
 			cdns3_rearm_transfer(priv_ep, priv_ep->wa1_set);
 	}
 
-	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP))
+	if ((ep_sts_reg & EP_STS_IOC) || (ep_sts_reg & EP_STS_ISP)) {
+		if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
+			if (ep_sts_reg & EP_STS_ISP)
+				priv_ep->flags |= EP_QUIRK_END_TRANSFER;
+			else
+				priv_ep->flags &= ~EP_QUIRK_END_TRANSFER;
+		}
+
 		cdns3_transfer_completed(priv_dev, priv_ep);
+	}
+
+	/*
+	 * WA2: this condition should only be meet when
+	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET or
+	 * priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN.
+	 * In other cases this interrupt will be disabled/
+	 */
+	if (ep_sts_reg & EP_STS_DESCMIS) {
+		int err;
+
+		err = cdns3_descmissing_packet(priv_ep);
+		if (err)
+			dev_err(priv_dev->dev,
+				"Failed: No sufficient memory for DESCMIS\n");
+	}
 
 	return 0;
 }
@@ -1241,13 +1440,26 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 	/* enable interrupt for selected endpoint */
 	cdns3_set_register_bit(&priv_dev->regs->ep_ien,
 			       BIT(cdns3_ep_addr_to_index(bEndpointAddress)));
+	/*
+	 * WA2: Set flag for all not ISOC OUT endpoints. If this flag is set
+	 * driver try to detect whether endpoint need additional internal
+	 * buffer for unblocking on-chip FIFO buffer. This flag will be cleared
+	 * if before first DESCMISS interrupt the DMA will be armed.
+	 */
+	if (quirk_internal_buffer) {
+		if (!priv_ep->dir && priv_ep->type != USB_ENDPOINT_XFER_ISOC) {
+			priv_ep->flags |= EP_QUIRK_EXTRA_BUF_DET;
+			reg |= EP_STS_EN_DESCMISEN;
+		}
+	}
 
 	writel(reg, &priv_dev->regs->ep_sts_en);
 
 	cdns3_set_register_bit(&priv_dev->regs->ep_cfg, EP_CFG_ENABLE);
 
 	ep->desc = desc;
-	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL);
+	priv_ep->flags &= ~(EP_PENDING_REQUEST | EP_STALL |
+			    EP_QUIRK_EXTRA_BUF_EN);
 	priv_ep->flags |= EP_ENABLED | EP_UPDATE_EP_TRBADDR;
 	priv_ep->wa1_set = 0;
 	priv_ep->enqueue = 0;
@@ -1272,6 +1484,7 @@ static int cdns3_gadget_ep_enable(struct usb_ep *ep,
 static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 {
 	struct cdns3_endpoint *priv_ep;
+	struct cdns3_request *priv_req;
 	struct cdns3_device *priv_dev;
 	struct usb_request *request;
 	unsigned long flags;
@@ -1308,6 +1521,14 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 				      -ESHUTDOWN);
 	}
 
+	while (!list_empty(&priv_ep->descmiss_req_list)) {
+		priv_req = cdns3_next_priv_request(&priv_ep->descmiss_req_list);
+
+		kfree(priv_req->request.buf);
+		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
+					     &priv_req->request);
+	}
+
 	while (!list_empty(&priv_ep->deferred_req_list)) {
 		request = cdns3_next_request(&priv_ep->deferred_req_list);
 
@@ -1348,6 +1569,53 @@ static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
 	priv_req = to_cdns3_request(request);
 	trace_cdns3_ep_queue(priv_req);
 
+	/*
+	 * WA2: if transfer was queued before DESCMISS appear than we
+	 * can disable handling of DESCMISS interrupt. Driver assumes that it
+	 * can disable special treatment for this endpoint.
+	 */
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_DET) {
+		u32 reg;
+
+		cdns3_select_ep(priv_dev, priv_ep->num | priv_ep->dir);
+		priv_ep->flags &= ~EP_QUIRK_EXTRA_BUF_DET;
+		reg = readl(&priv_dev->regs->ep_sts_en);
+		reg &= ~EP_STS_EN_DESCMISEN;
+		writel(reg, &priv_dev->regs->ep_sts_en);
+	}
+
+	/* WA2 */
+	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN) {
+		u8 pending_empty = list_empty(&priv_ep->pending_req_list);
+		u8 descmiss_empty = list_empty(&priv_ep->descmiss_req_list);
+
+		/*
+		 *  DESCMISS transfer has been finished, so data will be
+		 *  directly copied from internal allocated usb_request
+		 *  objects.
+		 */
+		if (pending_empty && !descmiss_empty &&
+		    !(priv_req->flags & REQUEST_INTERNAL)) {
+			cdns3_descmiss_copy_data(priv_ep, request);
+			list_add_tail(&request->list,
+				      &priv_ep->pending_req_list);
+			cdns3_gadget_giveback(priv_ep, priv_req,
+					      request->status);
+			return ret;
+		}
+
+		/*
+		 * WA2 driver will wait for completion DESCMISS transfer,
+		 * before starts new, not DESCMISS transfer.
+		 */
+		if (!pending_empty && !descmiss_empty)
+			deferred = 1;
+
+		if (priv_req->flags & REQUEST_INTERNAL)
+			list_add_tail(&priv_req->list,
+				      &priv_ep->descmiss_req_list);
+	}
+
 	ret = usb_gadget_map_request_by_dev(priv_dev->sysdev, request,
 					    usb_endpoint_dir_in(ep->desc));
 	if (ret)
@@ -1782,6 +2050,7 @@ static int cdns3_init_eps(struct cdns3_device *priv_dev)
 
 		INIT_LIST_HEAD(&priv_ep->pending_req_list);
 		INIT_LIST_HEAD(&priv_ep->deferred_req_list);
+		INIT_LIST_HEAD(&priv_ep->descmiss_req_list);
 	}
 
 	return 0;
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/gadget.h
index 817f8ae7a4da..8de733b315e9 100644
--- a/drivers/usb/cdns3/gadget.h
+++ b/drivers/usb/cdns3/gadget.h
@@ -1000,6 +1000,7 @@ struct cdns3_device;
  * @endpoint: usb endpoint
  * @pending_req_list: list of requests queuing on transfer ring.
  * @deferred_req_list: list of requests waiting for queuing on transfer ring.
+ * @descmiss_req_list: list of requests internally allocated by driver (WA2).
  * @trb_pool: transfer ring - array of transaction buffers
  * @trb_pool_dma: dma address of transfer ring
  * @cdns3_dev: device associated with this endpoint
@@ -1026,6 +1027,7 @@ struct cdns3_endpoint {
 	struct usb_ep		endpoint;
 	struct list_head	pending_req_list;
 	struct list_head	deferred_req_list;
+	struct list_head	descmiss_req_list;
 
 	struct cdns3_trb	*trb_pool;
 	dma_addr_t		trb_pool_dma;
@@ -1041,6 +1043,9 @@ struct cdns3_endpoint {
 #define EP_PENDING_REQUEST	BIT(5)
 #define EP_RING_FULL		BIT(6)
 #define EP_CLAIMED		BIT(7)
+#define EP_QUIRK_EXTRA_BUF_DET	BIT(8)
+#define EP_QUIRK_EXTRA_BUF_EN	BIT(9)
+#define EP_QUIRK_END_TRANSFER	BIT(10)
 
 	u32			flags;
 
@@ -1074,6 +1079,7 @@ struct cdns3_endpoint {
  * @start_trb: number of the first TRB in transfer ring
  * @end_trb: number of the last TRB in transfer ring
  * @flags: flag specifying special usage of request
+ * @list: used by internally allocated request to add to descmiss_req_list.
  */
 struct cdns3_request {
 	struct usb_request	request;
@@ -1086,6 +1092,7 @@ struct cdns3_request {
 #define REQUEST_INTERNAL_CH	BIT(2)
 #define REQUEST_ZLP		BIT(3)
 	u32			flags;
+	struct list_head	list;
 };
 
 #define to_cdns3_request(r) (container_of(r, struct cdns3_request, request))
-- 
2.17.1

