Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB5AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6452B20836
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbeL3SGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 13:06:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726321AbeL3SGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 13:06:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBUHwiSS067703
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 13:06:53 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ppq87surk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 13:06:53 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <jejb@linux.vnet.ibm.com>;
        Sun, 30 Dec 2018 18:06:52 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 30 Dec 2018 18:06:47 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBUI6krn13172922
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 30 Dec 2018 18:06:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D7B97806A;
        Sun, 30 Dec 2018 18:06:46 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A3E278064;
        Sun, 30 Dec 2018 18:06:44 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.80.193.237])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 30 Dec 2018 18:06:44 +0000 (GMT)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
From:   James Bottomley <jejb@linux.vnet.ibm.com>
To:     LEROY Christophe <christophe.leroy@c-s.fr>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Date:   Sun, 30 Dec 2018 10:06:43 -0800
In-Reply-To: <20181230185002.Horde.AdSknvcs4hP1Kh_T_Cos6w8@messagerie.si.c-s.fr>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
         <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
         <20181228173846.Horde.z_zDEJN0rVd8tkt3HjYzmg2@messagerie.si.c-s.fr>
         <alpine.LNX.2.21.1812291050330.152@nippy.intranet>
         <a170720a-fe17-744d-790b-e258465bd75e@gmail.com>
         <alpine.LNX.2.21.1812291327380.152@nippy.intranet>
         <5e901432-65e2-c87b-31e3-36a394687a9a@gmail.com>
         <CAK8P3a1J3sy55nd5QbxR5AjxkLyE-RE=bDNKB9sG27xx=mZ60A@mail.gmail.com>
         <20181230185002.Horde.AdSknvcs4hP1Kh_T_Cos6w8@messagerie.si.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18123018-0012-0000-0000-000016F14095
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010317; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000272; SDB=6.01139345; UDB=6.00592790; IPR=6.00919542;
 MB=3.00024903; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-30 18:06:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18123018-0013-0000-0000-000055A18D29
Message-Id: <1546193203.2844.9.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-30_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812300166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-30 at 18:50 +0100, LEROY Christophe wrote:
> Arnd Bergmann <arnd@arndb.de> a écrit :
> > On Sat, Dec 29, 2018 at 3:51 AM Michael Schmitz
> > <schmitzmic@gmail.com> wrote:
[...]
> > > (On second thought - I don't want to speculate whether there's
> > > weird compiler options that could result in the
> > > nvram_check_checksum and nvram_read_bytes symbols to still be
> > > referenced in the final link, even though
> > > IS_BUILTIN(CONFIG_NVRAM) always evaluates to false. Best
> > > leave this as-is.)
> > 
> > As far as I know, it's totally reliable with the supported
> > compilers  (gcc-4.6+). In the older compilers (e.g. 4.1), there was
> > a corner case, where it could have failed to eliminate a function
> > that was only referenced through a pointer from a discarded
> > variable, but a plain IS_ENABLED() check like the one here
> > was still ok, and lots of code relies on that.
> > 
> > Other than that, I agree either way is totally fine here, so no
> > objections to using the #ifdef.
> 
> As far as I know, kernel codying style promotes the use of  
> IS_ENABLED() etc. instead of #ifdefs when possible.

It's a preference, as with a lot of coding style stuff, which we leave
up to the maintainer.

That said, as has been pointed out, the current #ifdef has a failing
corner case when both are modular (because the code should then be
included).  The runtime macro that correctly expresses this is
IS_REACHABLE(CONFIG_NVRAM).

James

