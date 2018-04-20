Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1183928-1524214909-2-4721089414260159923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CN'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524214909; b=E1t3pIiz8m1VJ0PAa8EVlUn1eHjCMWJqZvJI4kTi61frmH66gw
    f0Vtyej+ycAeOyjmyzsKOKdZo7qyADc4u63SdbauH0bRfllvUjc/GqIJmyBJqO21
    g8iWoUyGa8boMRNpm8z0H2x2wduu2c/RddMtWU5zkgp0HpRdCvfQL9biwfeHiCfL
    lyvBTyH9bfZD+k+c3LiYedIb0xtpZScAXI0HhG7OPCmBBtMqiG5QEsWtJYvaivOC
    RI9Ztk7NWyu0SagRxfy7Mn2honhBda5LUdo1DGDoQOwo+dt/5GDNDTKp4pwC/Puh
    ERu5lbRrvefWgDgxvtf3ZaUxmoTj98T5+dUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524214909;
    bh=Dj7ZwNAPcAgj2UTycd2cJFKUAJj6lJ6fi3lEAOgwWZs=; b=E9nMgrevcRK9
    vA8EGxQGMKm4igLrPrwA6uLDNe9AYkGKRR61aJlbWLK0W/jzLky6+eBSMx1aQqUL
    TriEA7kNhwl16k6w2oi7zusmttvhQvTJG98xC3p0f6341NweFScCSUnYKd+PSYqv
    oIL7AM82ud2z9N1QDEalhThrWCQqy6vns6E1cV0F1dWZBy0tUc9IOieDLn/KpY7U
    AQAJ9h1RuewzcYhz1SUnqusgueJLb/tW9kKyKB5zcc/bmIcKP36onhGB8BpVno1p
    Ix6RDxDbdUSkqx7z+O1FRk/NFrv3pVxXh7Q7B9xMQxsOJjmlcuW7uwmpJ3LGYIZm
    Kznq736+Gg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=qcA44A19 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=qcA44A19 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOND0QWzETZ1Cl4b96Ymd3/xH33bdG8FNX1ewpWPmio4qfri6uh4CJTVFn6x2n9EuuM/NLlSaPqgNIVdloIAeEMxz2jjoU9JHlcQiqGLuNvmQ3TYuDcS
    NwTVOTUAlmfopztqENu7ZD6RD0WgmKbmVw6Q1sZB30cch2eGDtKvFd6M3sunWslnvNftEdpmFOV5sDO/kiYokT22/XwqQoaJFdJj1vOhyjkR4Pjd0QQck3RS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=32wYES3LoMUA:10 a=otyTMIrQUO0A:10 a=EFEsHzkWX8YA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=GxQisCVLOtIA:10 a=VwQbUJbxAAAA:8 a=-Zf3iGdb55IYR3Ov72oA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbeDTJBr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 05:01:47 -0400
Received: from mail-by2nam01on0047.outbound.protection.outlook.com ([104.47.34.47]:3152
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754074AbeDTJBp (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 20 Apr 2018 05:01:45 -0400
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synaptics.com;
Date: Fri, 20 Apr 2018 17:01:26 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH resend] usb: chipidea: Don't select EXTCON
Message-ID: <20180420170126.732e093b@xhacker.debian>
In-Reply-To: <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <20180419160144.0412a510@xhacker.debian>
        <HE1PR04MB1450E11255E0828180B3E8188BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY2PR01CA0004.jpnprd01.prod.outlook.com
 (2603:1096:404:a::16) To DM5PR03MB2636.namprd03.prod.outlook.com
 (2603:10b6:3:43::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;3:XFYEhxrVnknpTLcyktAX6i2S/sOlH0cNcYqU7S/BJ89rXpw5e4OKZ7SRyePsLhqDZd0B0lyOb8yswzPRubTbCBQMED4andIfA+r9nwodmn+0LBUHW7oCLZy+2DiEZBlp6I7jto8HN+YO2aXthvXdLsnD+I72LNUPBrlX+rqZ85pPRCEKcFU0H2OUhl8ddzmf9ukmZjo0FRiwi8FK50nckhrZoh2t89+8N1dbfYTJICR6S9adJVgRQ5HIUcJzscbV;25:/aqpUnYrUN9pPg2Rpq9zDIOVSIAmQvlf12Vd4rS2fSkrnB81dEPRsu7jeTfDXXopw90rw7ACbZCozBn5diR2tN9pR1VsSRUUpw+ZNf4VPVlMTJ+lQ95Xm+fBvX8E8zNH71gnEC119efYGjZeRV+/aHOmUAB7xOvE67dp0hYEVmKbY3X+AOK6UlCqjmvBe68SjrCBXqOThIgBUVGI+v35BxqprP2X8UMaP9Emku5plgstw2/4imwCFK+g0eBKOFF8KoN8p3EeBay3GUMjm7aQD/rtrG50usoBoJRtzTDNwU5f+AiwVST1ahBWTm/Lg/PTJnl1QNBUdRj62/Ndh9V3PA==;31:badg6RiMWbHyv0EDBBUteSYHDbcJ9c0lzlRVw2A7UiQpP7muOPMz9ZgKEPtGG+UnKGN4bgw+90PydF6LycAtXenSC8TopckTy7VMd3nTe6bzzokX9CDhJpmiUVFTHGD1Le7YjHdmsj+JmDSrWSkLOybjX6CocAGVbSVT6YtK5yXMSng1ViIeNypQfPmK1o4XuvsdvFuRTt2kpBHqCH+bQ2/CwfiWehnX6HNifHpPySQ=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;20:P2W67M+YzK0AkGPO0R0er/6/dNKhU3yCfK/+gJv9bjdSiYZKCMXXQx2e4Eh6Tw3qu9xh78iFSBcVnP+JIDWvmjiovd6TvB5CIR4jiRxpWgCyQGmU1s2MylkkI29CZqinZiIkng2z5BO+ZigjQU7+FG/MvP/ydbT1DG8wsqPQWg4WgrsE7fBKFhO2n4PRapWvqbBlf4OcIjZU3e7ecyZE/iHANX5i0VpeYXaJDF4RgF1obq6XW88uPVEsiXkzxWhEkwQQJVJqhjOE0Y0Rac2kjILTtVE9SZdYblVU/XtBTsqxhJtO7Ob/oG0y9ZJQSSiDgHpXgnXwowogZuOjP0CtmfODC9KRYYQ6dXTISy5s1fQC0qj4qOJCClQ1qn1DcVQnIcoE+sr89CibTB0Yp6HkE5dRLqEpHIMTMGOat0dKaQR4naKkqFaEn6JvVJA/oQfgkB0YMXexEvbkNuT6Ib4xdfYjqTSXlMnz9PAmhWqiYCKCqxCs6njm+vuDUIUme9Hu;4:sgiib08GRsIgMleHED9UosuS0hgcrRUatcMNB3LWWR/P5tPHf+gY1OO+RlQEJmnHJvhABPoM+cxB0huoMYuorTgtkyaVdklpWAmT+pTUDjGeBLxgpUaXj3NhUMMt0WmQSE/9s2DEQLLx78aMp0V8pYXZlr22o+qmkLFiirwNVmRFO2wfElrwA8JVSC6O7qU78hYobKV26RKS//ubvpa+bs8CK8leRSiNHSgW4tYWw82cLAwU95ZIZqun2+NMcxY5gs6wvQM1twXy+W2ajZrzKw==
X-Microsoft-Antispam-PRVS: <DM5PR03MB263694B345D1A01C8A4BA0FBEDB40@DM5PR03MB2636.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231232)(944501392)(52105095)(93006095)(93001095)(3002001)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR03MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2636;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(366004)(396003)(376002)(86362001)(66066001)(6246003)(3846002)(50466002)(54906003)(6116002)(6916009)(6666003)(1076002)(47776003)(575784001)(230700001)(23726003)(316002)(229853002)(4326008)(33896004)(8656006)(9686003)(55016002)(2906002)(8676002)(446003)(956004)(11346002)(59450400001)(76176011)(476003)(16526019)(5660300001)(52116002)(7736002)(305945005)(6506007)(186003)(7696005)(386003)(8936002)(478600001)(72206003)(25786009)(50226002)(81166006)(26005)(53936002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2636;H:xhacker.debian;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2636;23:YgeARaWJspj1vIk6ue46/7/ljVFhaQCd5b65cLvIc?=
 =?us-ascii?Q?FAvGjvpoXpPMXD1z4O/oCBxGWjp7SkGqgfoH8OaQEjiWM00+RhwchQlAmKPH?=
 =?us-ascii?Q?dt9dBbFeEyVKsyxD0zjzHt5hyBVc1WGXnlAeSN3NiEBGNzbh+jMbG+wcn+Rx?=
 =?us-ascii?Q?ySNUd3YtaMwOYqvPWXXqx7ODeAvFy1G2ee6NaMT5IPtSaz2CwWY2KMbpF1Cy?=
 =?us-ascii?Q?JylRDSm+GqFhodQVXNSPPacJ1nZwW3/3eznb5pN29RhTArY66ShCJK0IRegJ?=
 =?us-ascii?Q?xpcq9/ebeodXAmjkBFcjuwO7iLZKYXpWq2tfv7eis7aMGcfywHIbqPXi2D8N?=
 =?us-ascii?Q?POvC1YpSObcMnaMCr6cru5F128PCyG8HdxkUNtDiOR5KxR9CxZ0Pai+6U+ei?=
 =?us-ascii?Q?NSWxg1eYfvtp/T9Rp8COrxB3my/tYLVfwpp9NZiuINqEvJrkT2RwGWKEcZxO?=
 =?us-ascii?Q?7+N2eMH5jqtFQ//e6xgUS+wCKbHPMV7Xxj4Ls/+OBXxKqQEAndPRzhSZ+ta7?=
 =?us-ascii?Q?EXwoe+DwpV58b3S+ezYu8zbvpwu96IrhDVdL6qfSEFurFNrPJtCukpskrPTm?=
 =?us-ascii?Q?E3YSY28CF9watG7NaJf6S/IA9BgdHLfEHf+579/LcWS4h0NE0Mz5B8pUhmfl?=
 =?us-ascii?Q?B/ekMBs3L6hglpUukNesZZlUHVt/QdorZ59bdhlRSUb5prZpHBgNI+sdJ9aU?=
 =?us-ascii?Q?RmqPWy+PXpnxO1mGcv33EbcHpamA429ukgou+YBWdFtJKV9qyEuAcPfDUxO/?=
 =?us-ascii?Q?NeAOhVCuiRSCQt5AX5NAeTBV1es9KpT8fjeZCNxGi4Ai4GYsYt83emwCjwYR?=
 =?us-ascii?Q?A4b3vpgdQFS09qUuAm7c/u5cerYYsVqCtJk0XyZc+7ekNMq8sN8pA/zAPvAd?=
 =?us-ascii?Q?k/5gWYXfJ1yR3KbCVDseCVMOEqX7+lKFmX+CetaK8ojYbQXHV4PpLvqPzGmH?=
 =?us-ascii?Q?wG7Smyj5UlTb97MHqSzwwDv60JW+76GkEfACifst3SeptxqfoEHLTAu9Z3vy?=
 =?us-ascii?Q?/iOTJiT+c6njtDhmmUu0uVHIgpwdQflbML4yAm3T2+mNedxdON8hoJkgKR8O?=
 =?us-ascii?Q?jZ7ZI6rI0z0kXbjvXJGKBJ29BmhCZrpYCYQxFSB3KEHTxTp/dTEN6b1yM7f9?=
 =?us-ascii?Q?v/scs9uXogjE7eG9EPCXMMBmR+FbehUyQXbqb9Zbd3LSBbPmO8LAyC8gtXzo?=
 =?us-ascii?Q?v5MnmDp95r99uwUTlmSZ3nzk4rccgf4Sz78?=
X-Microsoft-Antispam-Message-Info: ztGQosVCDGc9mvssB4EyYuVzPGYQBNXRCa1OuhTBmP0awEFq/Ue6RCSjk4ptr/h2YX9ty4K4GwmoGkJeSiixjuDS5aNaOFv5VEJ3/UkXXZyqZTBix65oCD5kIggd8qO7kf1jroiKU2HhMDC+/LCYZ6oPZjZDLRQKw0fHCitQdIBab68B5GaIThRnMidHBlwd
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;6:cG0I7rCnqPTxFyI02cbAM0mLWb8aal0w57BCfggLhVuZctwf+XmdUMSaY0ays16o2vIX2fxEd4BZW4w5V71i4dED+5k43QzVw+V7Ug0XXc4xBaxVaEN5dgERDts7c7A7YSUuRxqvV1Ysg5bMovbeskmJbqyNgDlSwXjaPfZSPc806oe7HGENXBHXu1455oWurqJtqM3q2/6yrvLESHXxEJrAN5m1E6c6HZEzusYoyDaLBE2sVvNmOrQiHsFOG4hoSMXUvA0sjtFU+TVGbcMRt8+8qwgGt1+un/8OtI6xHIpV6lapgRuqfSfJ8hff0MHyvmIBArOJWMIvSAnBi6meRZRe/QclVPwRytKdQMQ4Ccjr4ULM8ILgBrMW0lpcLdM4K62ed0M+m5ocw5BxdB4x0aNxGd1/Z1px5H2AxedPBzNsDl10RO2tD8KJu/771MYfhCLb7AaHofeTxl7twtU7qA==;5:p3aqTM22JWB8BWAvx6QyTz53RdumD5BRxxkioeDVngDU+2jal0bdfY3PNCeQTP41MNQTOw8cYTaigFmWfRQnXxKKWvR3qSgTNHOo1x09eZjVN1XosBMJ6DbNDDExGBtOSSEm4dcmDFNqwgby3xNVkiSEbCOG0ic9TPEyNJzXncI=;24:ObPwmaWPDQHvDQVnVMwM8tA7byDm7PF6IMLXeshckeuGNbOOjEV824TjXzp5MOmwbNoKc8DakjnMJjHL2daPVBazyPkyD1gCtte8DSxdJvg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2636;7:8aAlV0r3/F8XGuk3KgV7LCDpo50R/AP49XBNd/8TOxBlmuauL8kFDcClOj04RURhx81lnV3x6VUQKGQyq/7m6MYj+UNWZinul06EzuV+Q0RFHt2ixI7r3uJHyYiAjKs5kRN0BTBftIowqgoMo6TtO6v8AlbPuXpHl62wVM63hxEUCEKmjiH9xKR8DFS+Tk2RVc1nfVWQ1i23X1mPshrxqyt/MRPoPQyIdRmOJ3mS8Fw099IeT04OeG7boI3dXz3o
X-MS-Office365-Filtering-Correlation-Id: e8b99719-a6bf-4432-02af-08d5a69d5682
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 09:01:41.8762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b99719-a6bf-4432-02af-08d5a69d5682
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2636
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Peter

On Fri, 20 Apr 2018 01:38:42 +0000 Peter Chen wrote:

>  
> >  drivers/usb/chipidea/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/usb/chipidea/Kconfig b/drivers/usb/chipidea/Kconfig index
> > 785f0ed037f7..97509172d536 100644
> > --- a/drivers/usb/chipidea/Kconfig
> > +++ b/drivers/usb/chipidea/Kconfig
> > @@ -1,7 +1,6 @@
> >  config USB_CHIPIDEA
> >  	tristate "ChipIdea Highspeed Dual Role Controller"
> >  	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD
> > && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
> > -	select EXTCON
> >  	select RESET_CONTROLLER
> >  	help
> >  	  Say Y here if your system has a dual role high speed USB
> > --
> > 2.17.0  
> 
> Hi Jisheng,
> 
> Sorry to reply late, are you really care 2KB code side? Since many users use
> EXTCON to handle vbus and id, it is hard just delete it. I could accept patch
> for your specific platforms, like:
> 
> +	select EXTCON if !ARCH_XXXX

The patch doesn't remove extcon support from chipidea driver.
I just want to not select EXTCON unconditionally, but let the users
choose. If the users need extcon, they could enable EXTCON themselves

I just searched all the dts in arch/arm/boot/dts and arch/arm64/boot/dts
only the four dts give extcon phandle to chipidea host, other users
don't make use of it:

arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi

arch/arm/boot/dts/qcom-apq8074-dragonboard.dts

arch/arm/boot/dts/qcom-msm8974-fairphone-fp2.dts

arch/arm/boot/dts/qcom-msm8974-sony-xperia-castor.dts

Thanks
