Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34845C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9150205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9150205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbeGYUuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:50:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49434 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729213AbeGYUuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:50:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PJXmP7070087
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:36:58 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2keu8fu18y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:36:57 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <muriloo@linux.ibm.com>;
        Wed, 25 Jul 2018 13:36:57 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 13:36:52 -0600
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PJaptT9830884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 12:36:51 -0700
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B09C605B;
        Wed, 25 Jul 2018 13:36:51 -0600 (MDT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C28CC6055;
        Wed, 25 Jul 2018 13:36:50 -0600 (MDT)
Received: from localhost (unknown [9.85.190.157])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 13:36:50 -0600 (MDT)
Date:   Wed, 25 Jul 2018 16:36:47 -0300
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     Michael Neuling <mikey@neuling.org>
Cc:     linux-kernel@vger.kernel.org,
        "Alastair D'Silva" <alastair@d-silva.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Cyril Bur <cyrilbur@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Simon Guo <wei.guo.simon@gmail.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-TM-AS-GCONF: 00
x-cbid: 18072519-0004-0000-0000-000014688CE1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009426; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01066054; UDB=6.00547670; IPR=6.00843914;
 MB=3.00022322; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-25 19:36:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072519-0005-0000-0000-00008836F835
Message-Id: <20180725193647.GA23643@kermit-br-ibm-com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250207
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mikey.

On Wed, Jul 25, 2018 at 05:00:21PM +1000, Michael Neuling wrote:
>  On Tue, 2018-07-24 at 16:27 -0300, Murilo Opsfelder Araujo wrote:
> > Hi, everyone.
> > 
> > This series was inspired by the need to modernize and display more
> > informative messages about unhandled signals.
> > 
> > The "unhandled signal NN" is not very informative.  We thought it would
> > be helpful adding a human-readable message describing what the signal
> > number means, printing the VMA address, and dumping the instructions.
> > 
> > We can add more informative messages, like informing what each code of a
> > SIGSEGV signal means.  We are open to suggestions.
> > 
> > I have collected some early feedback from Michael Ellerman about this
> > series and would love to hear more feedback from you all.
> 
> Nice.. the instruction dump would have been very handy when debugging the PCR
> init issue I had a month or so back.
> 
> > Before this series:
> > 
> >     Jul 24 13:01:07 localhost kernel: pandafault[5989]: unhandled signal 11 at 00000000100007d0 nip 000000001000061c lr 00003fff85a75100 code 2
> > 
> > After this series:
> > 
> >     Jul 24 13:08:01 localhost kernel: pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
> >     Jul 24 13:08:01 localhost kernel: Instruction dump:
> >     Jul 24 13:08:01 localhost kernel: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
> >     Jul 24 13:08:01 localhost kernel: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
> 
> What happens if we get a sudden flood of these from different processes that
> overlap their output? Are we going to be able to match up the process with
> instruction dump?

As to the flood of messages, ___ratelimit() makes me think that we'll
likely see some warn messages informing how many show_signal_msg()
callbacks were suppressed, instead of interleaved messages and
instruction dumps.

As to matching process with instruction dump, I believe we'd need more
information to glue them together.

What if we modify show_instructions() to accept a string prefix to be
printed along with each line?

> Should we prefix every line with the PID to avoid this?

That's possible.  An alternative would be prefixing each line with the
process name and its PID, as in the first line.  For example:

    pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
    pandafault[10758]: Instruction dump:
    pandafault[10758]: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
    pandafault[10758]: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

The above can be interleaved with other messages and we'll still be able
to match process and its corresponding instruction dump.

Cheers
Murilo

