Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB07C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75CD20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Di/wN5TI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E75CD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388037AbeGSSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:47:00 -0400
Received: from mail-sn1nam01on0040.outbound.protection.outlook.com ([104.47.32.40]:32393
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731699AbeGSSnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muwS+kwMeXN9sQZoc9D6nsbEjpbZRtyTXNBODuwOtZQ=;
 b=Di/wN5TImmIZ0ggSCMUX7U0rI4qVVpZu2+hOR33G6JjywgF5dpm2wwnPLfp3SNRZ68zAftexEEKexVfFTyXaCP7KlPVaH/MFxhhpx7Hdoyx6Dxav6uEp3rlPXBxtz7V1owuUhCFF/fvj48QzEInVp+loquBQZtv6PuTec+82Bns=
Received: from BY2PR07CA0094.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::47) by CY1PR07MB2299.namprd07.prod.outlook.com
 (2a01:111:e400:c5b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.21; Thu, 19 Jul
 2018 17:59:21 +0000
Received: from DM3NAM05FT033.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::205) by BY2PR07CA0094.outlook.office365.com
 (2a01:111:e400:7bff::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:20 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT033.mail.protection.outlook.com (10.152.98.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS4019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:19 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxC8P005823;
        Thu, 19 Jul 2018 18:59:12 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxCUJ005821;
        Thu, 19 Jul 2018 18:59:12 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 14/31] usb: usbssp: added procedure handling command completion events.
Date:   Thu, 19 Jul 2018 18:57:47 +0100
Message-ID: <1532023084-28083-15-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(36092001)(189003)(199004)(446003)(126002)(50226002)(476003)(2616005)(11346002)(2906002)(106466001)(8936002)(105596002)(486006)(42186006)(76176011)(54906003)(87636003)(26826003)(316002)(478600001)(16586007)(36756003)(186003)(51416003)(1671002)(426003)(26005)(50466002)(336012)(48376002)(575784001)(4326008)(86362001)(107886003)(109986005)(246002)(8676002)(14444005)(5660300001)(4720700003)(47776003)(356003)(6666003)(305945005)(7636002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2299;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT033;1:Tkcmu3ert7CPyAFVTfB8IwAMBMESfZLcJ8Ei/LUNmO0eqRrFFZWU5eV5+V2lBG/x6ymqz+isiFnLmiDLtH4I2Qm7KfixrE5TWeZUMdejT+ulHQTDAf53kaX7CPph5JRA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 016122ac-f7b6-43c7-8fce-08d5eda15a5c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:CY1PR07MB2299;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2299;3:jsUnyS9Mp1mpjLIXPiNhfnwc/Tstj8DiZTxGMEB6m97rZAWnnbr36xD1uEX4DhC1JsSUvDuzmnT4EyrqRA+zmyRdbYkZ8hB/C4brwx/FknsBtNE3A4Y+Kxu0jQDry/957cWXZ5T2g8cLByE8hjt3HxLqiuUVP2IeHIKDRCwc0FiUWYN8Xvc0znPP0b5h0NYAnUie1DBAse0wImNbCkoLEQl8tbw6ssrgHKWVRvc87lzOC6exy7Lg0iMWdNm7KYHkybJHoCTWMq2vjqyit+7ZSWAxQ2reiw0I72A0hDBWpb6LP7v0DpMOkCLDJgivSqfo1YkwwA+sJBk8B208LPTK7F/jM4e+u2sfdvyeeoDjOP8=;25:U3kLPDrUF3C48vy9nmJP6v38fTSvUiAPmy+vU1bzalEsTg75V3ERC9GoDtYHMfDPC5MYh4Mrz9ievs9NUlmcudK7PwdYAR3K5NIhfEYgeCAPCRHbpKJNvDKe5xHhPHBlJaGeNLgI/ML8JO4QbjKkOL6HH7jKDKDWdgCw7GCesz6O5DDGKq5IQ+Uh3Ag+VezcmbENT0OLfhMg9jUx1RZY8Rt2sWcSVD06/oVvpe9n3/9nbW5uFPsmrGyEio5OPNMQZ4k06rQ4ZMixZRP72hReRGQD2i8/pHZM/Fcs21zoWljA+pWVx5IpPpRiJknHEqzIvLDNRauYfzeBe5JwxFvbqg==
X-MS-TrafficTypeDiagnostic: CY1PR07MB2299:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2299;31:7ria8XWKBscNC0Fi8txOrjF9GXapSfhm1Nq9guKZS2+X2S8fMX7H0ubZCkm5FCsAd3EMp1DO1YPdFQ0+TZKXUBolWfTCddGbZpvs8lS9BsUTaNHfrE5jttPu8RS9oxSQSUZd3m6y+uK/yJjUWWboIfU+pGWGrhyFybwzxCrpv49+W0V+sH3EY3XreWdBvp3mM7cyVQL4R7YREfzjJV0S47dG0sjJ1BvZLye4kNiViic=;20:C9hs2DvmqqsK4ia3oo+suz+qVxEST629DCVkmONQEVmq6KP7puAgBuaBn4TufWXhZid6cpoiu0QCZjYJ4FqpUB0/6lnxiQ82OUWlCx2X2JI/rc+n54sw/OHJuKE88jAw/ADfOwapnGNbBLmBOjNZ7JYq5konJ8b9JmxMEYVXQyBjE/fQrI8gYJk9TlGeAtCy5Jk1ATnfD6tlIlvOZZ5wRwhGiKudPTqCM12vEkFQboR281NjTZayrUhRUVA4qGpldp1ojP2JzG/3oAGHHMF0uhlGBNb08jbO6u1tLLM7uxDg50Xw4QfEQORSJx5GhpcgD4O93A9Lgrzb5ZkNnArX4wSmajU/aHx+iyNR0vSxB+MhzPKYw8T4rQMMRmDtsZgByQfHdH6yeXe1Vrjg0pmIPXzj+V+yGX1UK5CL3JxzcEUJQ4TtVinzySTw4E+tcWIS5sZeaFi2nldDNG1HFrr5InYpXlA3sfRl1n4b3YBarqVv5WJftGhz+RXcXxFhq6QT
X-Microsoft-Antispam-PRVS: <CY1PR07MB22997C42D915239CB4A6A846DD520@CY1PR07MB2299.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:CY1PR07MB2299;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2299;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2299;4:N9GuldY7OAocIuuyco7fBuIuxipP5i77SnUMu4NYH5yRz0+tmo72RMfbiRO191Och+Rhf74v4vwdbTe9ABWUgiG4BrnatpuC79s0Q57BdVEh6ssL8GgNyo5vuHh1WNKj57wAzVxwVZJN4+WUsGzdlM6fRsgTgZ0LZjM9SvOHWFCfmwHJ5NYtLnrGW9oASDhcwtzeFS+5qscAP3YOADkTsrz0yvLZMdrc9iumEmpSpqP3vdSi0501Qj9a9R+VT7IFgjkm2L2iYz2v4ufadCbbqmwiZu9ltV/J2C5JJ612J13hhvDfcau2OtRy/LTd1jNc
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2299;23:soa0H0RSJ6rjNBjrvVdxRggOPAg8MMnbu5zd+vaM9?=
 =?us-ascii?Q?W6el3VoqBEw1y3BM1dp9UsWTfjhU7HyLWLhvnNdnQJIIBTrPmHEamMhi929p?=
 =?us-ascii?Q?PkpoLlFKfNb4ZwJf3mVHbg0YnT318dVPjHKqVZ+imZrZgxe22OKBiPVXpqQc?=
 =?us-ascii?Q?RhSckP4thIXe0ytslHJQVULsbQCmpARX5nWIYe3819AMlQ6Tlzbj5gnALtgG?=
 =?us-ascii?Q?q58Df4Ra8AcXGvGj02bM77cxEtUMFBSA6nb0CI1Odtpu4Nxhb8ed2TzHxtos?=
 =?us-ascii?Q?2xoosBOUVc7721dwIT3DZt+hzGf2BCYaeRp6SUecnZ6VwLnrIwIoTduVM+Kp?=
 =?us-ascii?Q?5ok1X90A25E5T+LbADG5+cVgSGE+yYpXeeiIYfFRDRoAFfwvJnJHlXshrJTH?=
 =?us-ascii?Q?7FcxpprO82iwATewCu5y9Eg4/QENXhiHsVCf6D98bMDzn7tTr016TPssHqyD?=
 =?us-ascii?Q?af35iZvtgGdOj3zrzUVflwsc4LEsNBtM/mH0Ki4PDNRle2e7DvdYcbNfpLoB?=
 =?us-ascii?Q?T0Xx1A6NuWfSvnDZ2juWlkJj1QRcOmw1OTtv55jQhq9dvEv0yczvaQAdvO3r?=
 =?us-ascii?Q?RuEol02dJ6ieWJfIXStrlba//yIROzGMo7ojhtUEoPu+igvf7W000UPcWfTp?=
 =?us-ascii?Q?RMmt57jveGhVVUcOVzfQV2c8sBBvkb7vSoWWhb7Y7+ogaX/LtiqqRP/cRNnO?=
 =?us-ascii?Q?M5eZmu+sZDEveEZ59z8nERjr/wommwPPmt1WBUjlFUj/HMyq60CWY0mGMlPN?=
 =?us-ascii?Q?wF854arfnkdAxkmp19JMNR6stsmENLkG4z3tFtmZky95wq6SOhTbiiieInla?=
 =?us-ascii?Q?bpM/10ud9Y1/O+Yqm7Ea50qEQ7XGWIpxYD4/BN1jfZ9Oz9WkEy7S6AvB2Dia?=
 =?us-ascii?Q?nf/8koxERbH3t7RfP2o0JHicJQf/N0eYPb9S8/+YwBtWjGyiomEh39gyh8MP?=
 =?us-ascii?Q?aY5gXKuHdwX9IrDR3u/3L5iHErp54YfVykGNtK4aP8potCMfxjGoHw6bOcwT?=
 =?us-ascii?Q?pmR3o/m9FSxocEkcOgrqVL4tN/BBkMm9+HYqVaQfY8Zmvi11BlXZLrB9QAqD?=
 =?us-ascii?Q?NECbyIJkAnOWOT/xWOYeeF+A38egu+ZHoZXCnWNDaGgc8HKPCPalt3KoyyBJ?=
 =?us-ascii?Q?Z0x8va1KPgM8lV9fg0MvEcZ4TdocJ6hIvJ0N8q88J4vwyTOJ28p86f5v9e2L?=
 =?us-ascii?Q?kZRwc+c3Pd9g0Q=3D?=
X-Microsoft-Antispam-Message-Info: 5tLSxxSXhZK7YrENHd5DEMzpIwbZgza8PKaGQLvZ1BEOrelLe3LuICnhPg3XzT5ISLlrrnyT0u5bTLBoSpzr9LsheKSmFc+6rWIl2haSdHhqMtFCuobALhsKOzy9xMXTxc6h4SA4nZ/r39x+kura/tI5JFWSkAd0a4I7og6J8MdYdcHLOM9daKUWxMbsUzOY9LBv95Fto15EieYOHmdMPC5qD1yg3Xm0k/UTFdUOS+CZGop/gmWHpmQkT+1JabP2QcevT37s9Lf3MeJ7Kymlta3MQuDez0N+VtE8nlGaWgfc5pKWG2s71ePQtD5Qxedu2uwQZhGUOl9hs32Tyd0xvjEPcRJ5RZLqf75qfb6/JK5SiBDU20+homMUoWGwkGZ1Rc8kdWVeoxEytoUE3yX/PA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2299;6:YNCV84VW3FfzpO2WSN429T2gbqm81idK+Y1xSPCeyXQkiw09vgJoz+SiXWLNURVQoDBWy9vG7PP9djL/h+Gi2PApBmUulNcaQ/e6w9oNlo6eFbTtuh0dpzt+HIHgmtgeSBBhtXbNI92wNTmbwyblqTzamyMxkPQsg4qq65e5soe0y4giZMjOjUg5k7TAgU3n3mFRJnUM2mtE8FYh5bQgMozG5HkMZzY7QUSb5FnQ3SeKNc/Q9vd8Irzn8LoW0ZQCsS0IE+5uN6W/VLhc74w3TICvC8VAzJiIHjFfirkKRLXsSjI+9bZtvxFYIpYY3XSoBY/VuSXg66XzMCxcRvrJVId6Rw56x6oroQBG6GpQQ2uFBV9jo09HNSv2MY8xygnl1BOwiXkiCpsAS3gcbmuknaRTdThiJpW1cXD+RE6oZ81GVdoVWV1cN4owAGff/UvvERGmvSW9xQffJhAwRqI3iA==;5:7m8uVRCn6UEqZrX3F6wx7wr6ek/Ok+JhsXg+oXBWoh8LE0RN+njh/1z/Iw7gk7xBH4wR1/9UcCu2Vy6int1X1vlq8RyVS6xvggYECMJNNIIHg2c650pHseJGiMVpbiz6vDnH/dEZpcnm1G6z5alK3704xHad3hAwj3VCsy7kNLQ=;24:Nvt4MXWoSC3ETyOG3sxo0QwXMPQnuJi49gQvP/Veoj53xzY/5g4lo51ud/Tbv3dtkOluQe/Ake0Om2jrCPgHbjFp955BNmOyVcsJOjex52c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2299;7:7TGSeqC8MxhiTGcfVidSRr3s7iQq1NACEsRANl0xL+JWGgWVniisWOTj50xMEwigsDmRw9b4Pmvcsu4iBun4z7ryDyYS5MLCJYTvHsi/QPeNUQg0STwaReojQeRMy6p1OJ/Q540NQ8YIBYn1CV55ZPfFzpRCac1z3bMqjJTrXPvT/IoseuXYfbgUaQqBPr2N2tuc940gUpYEgF7H0Xfq4ub2fVQG1LHW07RMIWnvHjXJHtTNjCaioMt6YWuIcdJi;20:+XSerbO1E5HDAvSSQWikipeYgQfBHX9WzIjmF5/9TMEsF2JhViMqxK8GVssIm4bH1uzxV/ACk5Ozlb5o6Ey99Co9LeM0Gs9S6U9ubH7hGMTfPAJpfxfKgpUaVoF7ghy84bbPUMD9onFIyXyvja6N9LgTYsYp55IdTJeihYzYimWyNOq6RgslXGr0RtdWlt9smnmGDGVHSGPfHO9A0MKguuQnEtsGRFQEHDeCAPbwv8anr2ZRNwiORpJJdACdPpRr
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:20.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 016122ac-f7b6-43c7-8fce-08d5eda15a5c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2299
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the usbssp_handle_event function with a new case,
that is responsible for servicing command completion events.

For this purpose, it adds handle_cmd_completion function which in turn
invokes some other functions depending of handling command type.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  |  53 +++-
 drivers/usb/usbssp/gadget-ring.c | 510 +++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c      |  11 +
 drivers/usb/usbssp/gadget.h      |  12 +
 4 files changed, 584 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index fef83b6b6cf0..5708a0090ead 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -504,6 +504,38 @@ void usbssp_free_container_ctx(struct usbssp_udc *usbssp_data,
 	kfree(ctx);
 }
 
+struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
+					struct usbssp_container_ctx *ctx)
+{
+	if (ctx->type != USBSSP_CTX_TYPE_INPUT)
+		return NULL;
+
+	return (struct usbssp_input_control_ctx *)ctx->bytes;
+}
+
+struct usbssp_slot_ctx *usbssp_get_slot_ctx(struct usbssp_udc *usbssp_data,
+					    struct usbssp_container_ctx *ctx)
+{
+	if (ctx->type == USBSSP_CTX_TYPE_DEVICE)
+		return (struct usbssp_slot_ctx *)ctx->bytes;
+
+	return (struct usbssp_slot_ctx *) (ctx->bytes +
+		CTX_SIZE(usbssp_data->hcc_params));
+}
+
+struct usbssp_ep_ctx *usbssp_get_ep_ctx(struct usbssp_udc *usbssp_data,
+					struct usbssp_container_ctx *ctx,
+					unsigned int ep_index)
+{
+	/* increment ep index by offset of start of ep ctx array */
+	ep_index++;
+	if (ctx->type == USBSSP_CTX_TYPE_INPUT)
+		ep_index++;
+
+	return (struct usbssp_ep_ctx *) (ctx->bytes +
+		(ep_index * CTX_SIZE(usbssp_data->hcc_params)));
+}
+
 /***************** Streams structures manipulation *************************/
 static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
 				   unsigned int num_stream_ctxs,
@@ -523,8 +555,25 @@ static void usbssp_free_stream_ctx(struct usbssp_udc *usbssp_data,
 				stream_ctx, dma);
 }
 
-/**
- * Frees all stream contexts associated with the endpoint,
+struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
+					     unsigned int ep_index,
+					     unsigned int stream_id)
+{
+	struct usbssp_ep *ep = &dev->eps[ep_index];
+
+	if (stream_id == 0)
+		return ep->ring;
+
+	if (!ep->stream_info)
+		return NULL;
+
+	if (stream_id > ep->stream_info->num_streams)
+		return NULL;
+	return ep->stream_info->stream_rings[stream_id];
+}
+
+/*
+ *  Frees all stream contexts associated with the endpoint,
  *
  * Caller should fix the endpoint context streams fields.
  */
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 6679d8ec7152..c704b939b48a 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -225,6 +225,107 @@ static bool usbssp_mod_cmd_timer(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+void usbssp_ring_ep_doorbell(struct usbssp_udc *usbssp_data,
+			     unsigned int ep_index,
+			     unsigned int stream_id)
+{
+	__le32 __iomem *db_addr =
+			&usbssp_data->dba->doorbell[usbssp_data->slot_id];
+	struct usbssp_ep *ep = &usbssp_data->devs.eps[ep_index];
+	unsigned int ep_state = ep->ep_state;
+	unsigned int db_value;
+
+	/*
+	 * Don't ring the doorbell for this endpoint if there are pending
+	 * cancellations because we don't want to interrupt processing.
+	 * We don't want to restart any stream rings if there's a set dequeue
+	 * pointer command pending because the device can choose to start any
+	 * stream once the endpoint is on the HW schedule.
+	 * Also we don't want restart any endpoint if endpoint is halted or
+	 * disabled and also if endpoint disabling is pending.
+	 */
+	if ((ep_state & EP_STOP_CMD_PENDING) ||
+	    (ep_state & SET_DEQ_PENDING) ||
+	    (ep_state & EP_HALTED) ||
+	    !(ep_state & USBSSP_EP_ENABLED) ||
+	    (ep_state & USBSSP_EP_DISABLE_PENDING))
+		return;
+
+	if (ep_index == 0 && !usbssp_data->ep0_expect_in &&
+	    usbssp_data->ep0state == USBSSP_EP0_DATA_PHASE)
+		db_value = DB_VALUE_EP0_OUT(ep_index, stream_id);
+	else
+		db_value = DB_VALUE(ep_index, stream_id);
+
+	dev_dbg(usbssp_data->dev, "// Ding dong transfer ring for %s!"
+		" - [DB addr/DB val]: [%p/%08x]\n",
+		usbssp_data->devs.eps[ep_index].name, db_addr,
+		db_value);
+
+	writel(db_value, db_addr);
+	/*
+	 * The CPU has better things to do at this point than wait for a
+	 * write-posting flush. It'll get there soon enough.
+	 */
+}
+
+/* Ring the doorbell for any rings with pending USB requests */
+static void ring_doorbell_for_active_rings(struct usbssp_udc *usbssp_data,
+					   unsigned int ep_index)
+{
+	unsigned int stream_id;
+	struct usbssp_ep *ep;
+
+	ep = &usbssp_data->devs.eps[ep_index];
+
+	dev_dbg(usbssp_data->dev, "Ring all active ring for %s\n",
+		ep->name);
+
+	/* A ring has pending Request if its TD list is not empty */
+	if (!(ep->ep_state & EP_HAS_STREAMS)) {
+		if (ep->ring && !(list_empty(&ep->ring->td_list)))
+			usbssp_ring_ep_doorbell(usbssp_data, ep_index, 0);
+		return;
+	}
+
+	for (stream_id = 1; stream_id < ep->stream_info->num_streams;
+			stream_id++) {
+		struct usbssp_stream_info *stream_info = ep->stream_info;
+
+		if (!list_empty(&stream_info->stream_rings[stream_id]->td_list))
+			usbssp_ring_ep_doorbell(usbssp_data, ep_index,
+						stream_id);
+	}
+}
+
+/*
+ * When we get a command completion for a Stop Endpoint Command, we need to
+ * stop timer and clear EP_STOP_CMD_PENDING flag.
+ */
+static void usbssp_handle_cmd_stop_ep(struct usbssp_udc *usbssp_data,
+				      union usbssp_trb *trb,
+				      struct usbssp_event_cmd *event)
+{
+	unsigned int ep_index;
+	struct usbssp_ep *ep;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_device *priv_dev;
+
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
+	ep = &usbssp_data->devs.eps[ep_index];
+
+	dev_dbg(usbssp_data->dev,
+		"CMD stop endpoint completion for ep index: %d - %s\n",
+		ep_index, ep->name);
+
+
+	priv_dev = &usbssp_data->devs;
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
+	trace_usbssp_handle_cmd_stop_ep(ep_ctx);
+
+	ep->ep_state &= ~EP_STOP_CMD_PENDING;
+}
+
 static void usbssp_kill_ring_requests(struct usbssp_udc *usbssp_data,
 				      struct usbssp_ring *ring)
 {
@@ -300,6 +401,262 @@ void usbssp_udc_died(struct usbssp_udc *usbssp_data)
 		usbssp_kill_endpoint_request(usbssp_data, i);
 }
 
+static void update_ring_for_set_deq_completion(struct usbssp_udc *usbssp_data,
+					       struct usbssp_device *dev,
+					       struct usbssp_ring *ep_ring,
+					       unsigned int ep_index)
+{
+	union usbssp_trb *dequeue_temp;
+	int num_trbs_free_temp;
+	bool revert = false;
+
+	num_trbs_free_temp = ep_ring->num_trbs_free;
+	dequeue_temp = ep_ring->dequeue;
+
+	if (trb_is_link(ep_ring->dequeue)) {
+		ep_ring->deq_seg = ep_ring->deq_seg->next;
+		ep_ring->dequeue = ep_ring->deq_seg->trbs;
+	}
+
+	while (ep_ring->dequeue != dev->eps[ep_index].queued_deq_ptr) {
+		/* We have more usable TRBs */
+		ep_ring->num_trbs_free++;
+		ep_ring->dequeue++;
+		if (trb_is_link(ep_ring->dequeue)) {
+			if (ep_ring->dequeue ==
+					dev->eps[ep_index].queued_deq_ptr)
+				break;
+			ep_ring->deq_seg = ep_ring->deq_seg->next;
+			ep_ring->dequeue = ep_ring->deq_seg->trbs;
+		}
+		if (ep_ring->dequeue == dequeue_temp) {
+			revert = true;
+			break;
+		}
+	}
+
+	if (revert) {
+		dev_dbg(usbssp_data->dev, "Unable to find new dequeue pointer\n");
+		ep_ring->num_trbs_free = num_trbs_free_temp;
+	}
+}
+
+/*
+ * When we get a completion for a Set Transfer Ring Dequeue Pointer command,
+ * we need to clear the set deq pending flag in the endpoint ring state, so that
+ * the TD queueing code can ring the doorbell again. We also need to ring the
+ * endpoint doorbell to restart the ring
+ */
+static void usbssp_handle_cmd_set_deq(struct usbssp_udc *usbssp_data,
+				      union usbssp_trb *trb, u32 cmd_comp_code)
+{
+	unsigned int ep_index;
+	unsigned int stream_id;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_device *dev;
+	struct usbssp_ep *ep;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
+	stream_id = TRB_TO_STREAM_ID(le32_to_cpu(trb->generic.field[2]));
+	dev = &usbssp_data->devs;
+	ep = &dev->eps[ep_index];
+
+	ep_ring = usbssp_stream_id_to_ring(dev, ep_index, stream_id);
+	if (!ep_ring) {
+		dev_warn(usbssp_data->dev,
+			"WARN Set TR deq ptr command for freed stream ID %u\n",
+			stream_id);
+		goto cleanup;
+	}
+
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev->out_ctx, ep_index);
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev->out_ctx);
+	trace_usbssp_handle_cmd_set_deq(slot_ctx);
+	trace_usbssp_handle_cmd_set_deq_ep(ep_ctx);
+
+	if (cmd_comp_code != COMP_SUCCESS) {
+		unsigned int ep_state;
+		unsigned int slot_state;
+
+		switch (cmd_comp_code) {
+		case COMP_TRB_ERROR:
+			dev_warn(usbssp_data->dev,
+				"WARN Set TR Deq Ptr cmd invalid because of "
+				"stream ID configuration\n");
+			break;
+		case COMP_CONTEXT_STATE_ERROR:
+			dev_warn(usbssp_data->dev, "WARN Set TR Deq Ptr cmd "
+				"failed due to incorrect slot or ep state.\n");
+			ep_state = GET_EP_CTX_STATE(ep_ctx);
+			slot_state = le32_to_cpu(slot_ctx->dev_state);
+			slot_state = GET_SLOT_STATE(slot_state);
+			usbssp_dbg_trace(usbssp_data,
+					trace_usbssp_dbg_cancel_request,
+					"Slot state = %u, EP state = %u",
+					slot_state, ep_state);
+			break;
+		case COMP_SLOT_NOT_ENABLED_ERROR:
+			dev_warn(usbssp_data->dev,
+					"WARN Set TR Deq Ptr cmd failed because"
+					" slot %u was not enabled.\n",
+					usbssp_data->slot_id);
+			break;
+		default:
+			dev_warn(usbssp_data->dev, "WARN Set TR Deq Ptr cmd with"
+					" unknown completion code of %u.\n",
+					cmd_comp_code);
+			break;
+		}
+
+	} else {
+		u64 deq;
+		/* deq ptr is written to the stream ctx for streams */
+		if (ep->ep_state & EP_HAS_STREAMS) {
+			struct usbssp_stream_ctx *ctx =
+				&ep->stream_info->stream_ctx_array[stream_id];
+			deq = le64_to_cpu(ctx->stream_ring) & SCTX_DEQ_MASK;
+		} else {
+			deq = le64_to_cpu(ep_ctx->deq) & ~EP_CTX_CYCLE_MASK;
+		}
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Successful Set TR Deq Ptr cmd, deq = @%08llx", deq);
+		if (usbssp_trb_virt_to_dma(ep->queued_deq_seg,
+		    ep->queued_deq_ptr) == deq) {
+
+			/*
+			 * Update the ring's dequeue segment and dequeue pointer
+			 * to reflect the new position.
+			 */
+			update_ring_for_set_deq_completion(usbssp_data, dev,
+				ep_ring, ep_index);
+		} else {
+			dev_warn(usbssp_data->dev,
+				"Mismatch between completed Set TR Deq "
+				"Ptr command & DC internal state.\n");
+			dev_warn(usbssp_data->dev,
+				"ep deq seg = %p, deq ptr = %p\n",
+				ep->queued_deq_seg, ep->queued_deq_ptr);
+		}
+	}
+
+cleanup:
+	dev->eps[ep_index].ep_state &= ~SET_DEQ_PENDING;
+	dev->eps[ep_index].queued_deq_seg = NULL;
+	dev->eps[ep_index].queued_deq_ptr = NULL;
+	/* Restart any rings with pending requests */
+	ring_doorbell_for_active_rings(usbssp_data, ep_index);
+}
+
+
+static void usbssp_handle_cmd_reset_ep(struct usbssp_udc *usbssp_data,
+				       union usbssp_trb *trb,
+				       u32 cmd_comp_code)
+{
+	struct usbssp_ep *dep;
+	struct usbssp_ep_ctx *ep_ctx;
+	unsigned int ep_index;
+
+	ep_index = TRB_TO_EP_INDEX(le32_to_cpu(trb->generic.field[3]));
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, usbssp_data->devs.out_ctx,
+			ep_index);
+	trace_usbssp_handle_cmd_reset_ep(ep_ctx);
+
+	/*
+	 * This command will only fail if the endpoint wasn't halted,
+	 * but we don't care.
+	 */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_reset_ep,
+			"Ignoring reset ep completion code of %u",
+			cmd_comp_code);
+
+	dep = &usbssp_data->devs.eps[ep_index];
+
+	/* Clear our internal halted state */
+	dep->ep_state &= ~EP_HALTED;
+
+	ring_doorbell_for_active_rings(usbssp_data, ep_index);
+}
+
+static void usbssp_handle_cmd_enable_slot(struct usbssp_udc *usbssp_data,
+					  int slot_id,
+					  struct usbssp_command *command,
+					  u32 cmd_comp_code)
+{
+	if (cmd_comp_code == COMP_SUCCESS) {
+		dev_dbg(usbssp_data->dev,
+			"CMD enable slot complition successfully "
+			"- slto id: %d\n", slot_id);
+		usbssp_data->slot_id = slot_id;
+	} else {
+		dev_dbg(usbssp_data->dev, "CMD enable slot complition failed\n");
+		usbssp_data->slot_id = 0;
+	}
+}
+
+static void usbssp_handle_cmd_disable_slot(struct usbssp_udc *usbssp_data)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	dev_dbg(usbssp_data->dev, "CMD disable slot complition\n");
+
+	dev_priv = &usbssp_data->devs;
+	if (!dev_priv)
+		return;
+
+	usbssp_data->slot_id = 0;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_handle_cmd_disable_slot(slot_ctx);
+}
+
+static void usbssp_handle_cmd_config_ep(struct usbssp_udc *usbssp_data,
+					struct usbssp_event_cmd *event,
+					u32 cmd_comp_code)
+{
+	struct usbssp_device *priv_dev;
+	struct usbssp_input_control_ctx *ctrl_ctx;
+	struct usbssp_ep_ctx *ep_ctx;
+	unsigned int ep_index;
+	u32 add_flags, drop_flags;
+
+	/*
+	 * Configure endpoint commands can come, becaouse device
+	 * receive USB_SET_CONFIGURATION or SET_INTERFACE request,
+	 * or because the HW needed an extra configure endpoint
+	 * command after a reset or disconnect event.
+	 */
+	priv_dev = &usbssp_data->devs;
+	ctrl_ctx = usbssp_get_input_control_ctx(priv_dev->in_ctx);
+	if (!ctrl_ctx) {
+		dev_warn(usbssp_data->dev,
+			"Could not get input context, bad type.\n");
+		return;
+	}
+
+	add_flags = le32_to_cpu(ctrl_ctx->add_flags);
+	drop_flags = le32_to_cpu(ctrl_ctx->drop_flags);
+	/* Input ctx add_flags are the endpoint index plus one */
+	ep_index = usbssp_last_valid_endpoint(add_flags) - 1;
+
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
+	trace_usbssp_handle_cmd_config_ep(ep_ctx);
+}
+
+static void usbssp_handle_cmd_reset_dev(struct usbssp_udc *usbssp_data,
+					struct usbssp_event_cmd *event)
+{
+	struct usbssp_device *dev_priv;
+	struct usbssp_slot_ctx *slot_ctx;
+
+	dev_priv = &usbssp_data->devs;
+	slot_ctx = usbssp_get_slot_ctx(usbssp_data, dev_priv->out_ctx);
+	trace_usbssp_handle_cmd_reset_dev(slot_ctx);
+	dev_dbg(usbssp_data->dev, "Completed reset device command.\n");
+	if (!usbssp_data->devs.gadget)
+		dev_warn(usbssp_data->dev, "Reset device command completion\n");
+}
 
 void usbssp_handle_command_timeout(struct work_struct *work)
 {
@@ -327,6 +684,156 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
 
+static void handle_cmd_completion(struct usbssp_udc *usbssp_data,
+				  struct usbssp_event_cmd *event)
+{
+	int slot_id = TRB_TO_SLOT_ID(le32_to_cpu(event->flags));
+	u64 cmd_dma;
+	dma_addr_t cmd_dequeue_dma;
+	u32 cmd_comp_code;
+	union usbssp_trb *cmd_trb;
+	struct usbssp_command *cmd;
+	u32 cmd_type;
+
+	cmd_dma = le64_to_cpu(event->cmd_trb);
+	cmd_trb = usbssp_data->cmd_ring->dequeue;
+
+	trace_usbssp_handle_command(usbssp_data->cmd_ring, &cmd_trb->generic);
+
+	cmd_dequeue_dma = usbssp_trb_virt_to_dma(usbssp_data->cmd_ring->deq_seg,
+			cmd_trb);
+
+	/*
+	 * Check whether the completion event is for our internal kept
+	 * command.
+	 */
+	if (!cmd_dequeue_dma || cmd_dma != (u64)cmd_dequeue_dma) {
+		dev_warn(usbssp_data->dev,
+			"ERROR mismatched command completion event\n");
+		return;
+	}
+
+	cmd = list_entry(usbssp_data->cmd_list.next, struct usbssp_command,
+			cmd_list);
+
+	cancel_delayed_work(&usbssp_data->cmd_timer);
+
+	cmd_comp_code = GET_COMP_CODE(le32_to_cpu(event->status));
+
+	/* If CMD ring stopped we own the trbs between enqueue and dequeue */
+	if (cmd_comp_code == COMP_COMMAND_RING_STOPPED) {
+		complete_all(&usbssp_data->cmd_ring_stop_completion);
+		return;
+	}
+
+	if (cmd->command_trb != usbssp_data->cmd_ring->dequeue) {
+		dev_err(usbssp_data->dev,
+			 "Command completion event does not match command\n");
+		return;
+	}
+
+	/*
+	 * device aborted the command ring, check if the current command was
+	 * supposed to be aborted, otherwise continue normally.
+	 * The command ring is stopped now, but the DC will issue a Command
+	 * Ring Stopped event which will cause us to restart it.
+	 */
+	if (cmd_comp_code == COMP_COMMAND_ABORTED) {
+		usbssp_data->cmd_ring_state = CMD_RING_STATE_STOPPED;
+
+		if (cmd->status == COMP_COMMAND_ABORTED) {
+			if (usbssp_data->current_cmd == cmd)
+				usbssp_data->current_cmd = NULL;
+			goto event_handled;
+		}
+	}
+
+	cmd_type = TRB_FIELD_TO_TYPE(le32_to_cpu(cmd_trb->generic.field[3]));
+	switch (cmd_type) {
+	case TRB_ENABLE_SLOT:
+		usbssp_handle_cmd_enable_slot(usbssp_data, slot_id,
+					cmd, cmd_comp_code);
+		break;
+	case TRB_DISABLE_SLOT:
+		usbssp_handle_cmd_disable_slot(usbssp_data);
+		break;
+	case TRB_CONFIG_EP:
+		if (!cmd->completion)
+			usbssp_handle_cmd_config_ep(usbssp_data, event,
+						cmd_comp_code);
+		break;
+	case TRB_EVAL_CONTEXT:
+		break;
+	case TRB_ADDR_DEV: {
+		struct usbssp_slot_ctx *slot_ctx;
+
+		slot_ctx = usbssp_get_slot_ctx(usbssp_data,
+					usbssp_data->devs.out_ctx);
+		trace_usbssp_handle_cmd_addr_dev(slot_ctx);
+		break;
+	}
+	case TRB_STOP_RING:
+		WARN_ON(slot_id != TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3])));
+		usbssp_handle_cmd_stop_ep(usbssp_data, cmd_trb, event);
+		break;
+	case TRB_SET_DEQ:
+		WARN_ON(slot_id != TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3])));
+		usbssp_handle_cmd_set_deq(usbssp_data, cmd_trb, cmd_comp_code);
+		break;
+	case TRB_CMD_NOOP:
+		/* Is this an aborted command turned to NO-OP? */
+		if (cmd->status == COMP_COMMAND_RING_STOPPED)
+			cmd_comp_code = COMP_COMMAND_RING_STOPPED;
+		break;
+	case TRB_HALT_ENDPOINT:
+		if (cmd->status == COMP_COMMAND_RING_STOPPED)
+			cmd_comp_code = COMP_COMMAND_RING_STOPPED;
+		break;
+	case TRB_FLUSH_ENDPOINT:
+		if (cmd->status == COMP_COMMAND_RING_STOPPED)
+			cmd_comp_code = COMP_COMMAND_RING_STOPPED;
+		break;
+	case TRB_RESET_EP:
+		WARN_ON(slot_id != TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3])));
+		usbssp_handle_cmd_reset_ep(usbssp_data, cmd_trb, cmd_comp_code);
+		break;
+	case TRB_RESET_DEV:
+		/*
+		 * SLOT_ID field in reset device cmd completion event TRB is 0.
+		 * Use the SLOT_ID from the command TRB instead.
+		 */
+		slot_id = TRB_TO_SLOT_ID(
+				le32_to_cpu(cmd_trb->generic.field[3]));
+
+		WARN_ON(slot_id != 0);
+		usbssp_handle_cmd_reset_dev(usbssp_data, event);
+		break;
+	case TRB_FORCE_HEADER:
+		break;
+	default:
+		/* Skip over unknown commands on the event ring */
+		dev_info(usbssp_data->dev, "INFO unknown command type %d\n",
+			cmd_type);
+		break;
+	}
+
+	/* restart timer if this wasn't the last command */
+	if (!list_is_singular(&usbssp_data->cmd_list)) {
+		usbssp_data->current_cmd = list_first_entry(&cmd->cmd_list,
+					struct usbssp_command, cmd_list);
+		usbssp_mod_cmd_timer(usbssp_data, USBSSP_CMD_DEFAULT_TIMEOUT);
+	} else if (usbssp_data->current_cmd == cmd) {
+		usbssp_data->current_cmd = NULL;
+	}
+
+event_handled:
+	usbssp_complete_del_and_free_cmd(cmd, cmd_comp_code);
+	inc_deq(usbssp_data, usbssp_data->cmd_ring);
+}
+
 static void handle_port_status(struct usbssp_udc *usbssp_data,
 			       union usbssp_trb *event)
 {
@@ -596,6 +1103,9 @@ int usbssp_handle_event(struct usbssp_udc *usbssp_data)
 	rmb();
 
 	switch ((le32_to_cpu(event->event_cmd.flags) & TRB_TYPE_BITMASK)) {
+	case TRB_TYPE(TRB_COMPLETION):
+		handle_cmd_completion(usbssp_data, &event->event_cmd);
+		break;
 	case TRB_TYPE(TRB_PORT_STATUS):
 		handle_port_status(usbssp_data, event);
 		update_ptrs = 0;
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 2996b1d3baf7..6b3dc973c0d9 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -262,6 +262,17 @@ int usbssp_resume(struct usbssp_udc *usbssp_data, bool hibernated)
 
 #endif	/* CONFIG_PM */
 
+/* Compute the last valid endpoint context index. Basically, this is the
+ * endpoint index plus one. For slot contexts with more than valid endpoint,
+ * we find the most significant bit set in the added contexts flags.
+ * e.g. ep 1 IN (with epnum 0x81) => added_ctxs = 0b1000
+ * fls(0b1000) = 4, but the endpoint context index is 3, so subtract one.
+ */
+unsigned int usbssp_last_valid_endpoint(u32 added_ctxs)
+{
+	return fls(added_ctxs) - 1;
+}
+
 int usbssp_gen_setup(struct usbssp_udc *usbssp_data)
 {
 	int retval;
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 33eccffc885d..145371eee47d 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1685,9 +1685,13 @@ void usbssp_dbg_trace(struct usbssp_udc *usbssp_data,
 /* USBSSP memory management */
 void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data);
 int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags);
+unsigned int usbssp_last_valid_endpoint(u32 added_ctxs);
 int usbssp_ring_expansion(struct usbssp_udc *usbssp_data,
 			struct usbssp_ring *ring,
 			unsigned int num_trbs, gfp_t flags);
+struct usbssp_ring *usbssp_stream_id_to_ring(struct usbssp_device *dev,
+					unsigned int ep_index,
+					unsigned int stream_id);
 
 struct usbssp_command *usbssp_alloc_command(struct usbssp_udc *usbssp_data,
 					bool allocate_completion,
@@ -1732,6 +1736,14 @@ void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
 void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
 			__le32 __iomem *port_regs, u32 port_bit);
 
+/* USBSSP DC contexts */
+struct usbssp_input_control_ctx *usbssp_get_input_control_ctx(
+					struct usbssp_container_ctx *ctx);
+struct usbssp_slot_ctx *usbssp_get_slot_ctx(struct usbssp_udc *usbssp_data,
+					struct usbssp_container_ctx *ctx);
+struct usbssp_ep_ctx *usbssp_get_ep_ctx(struct usbssp_udc *usbssp_data,
+					struct usbssp_container_ctx *ctx,
+					unsigned int ep_index);
 /* USBSSP gadget interface*/
 void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data);
 void usbssp_resume_gadget(struct usbssp_udc *usbssp_data);
-- 
2.17.1

