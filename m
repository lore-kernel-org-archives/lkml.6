Return-Path: <schwidefsky@de.ibm.com>
X-Google-Smtp-Source: AB8JxZqq7ym8YhGxHsvqg3aLZRHtzWubXRaOeV1fWIT0SxNdkt6EvGusCQX5jhTEKaLFS7s5KbIH
ARC-Seal: i=1; a=rsa-sha256; t=1525673237; cv=none;
        d=google.com; s=arc-20160816;
        b=EEJYAbM3hbhffYATdLnejnXCflt+GClBPz7RgwIgnQHuVel/EA9g5u1K8LgjXZz36R
         KoUj2IAFW87xYcUmsQuFNpKdRQcLxBmleF1f3PWFqxS3eQKSey6U0xMR85ja9JwxRI36
         OTi25fLdOU70zhDqIl+LVwVwTzlusNraK0JCL+V2shCCQ6ZQU9d9AeAPMTILSUyDGuJx
         bm2077BCbopTaBNN1YxB+U8dVKPb5els7L7Y4vukVbAvT0KKW4vZBNH4Qiirmytwa4hf
         i2HRkJQIsMkdk7RZMKIwh+uJgW98TFHlAWQWZnHUJsC3ePmuhMFhj1GAwL1pendVXoYf
         N2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:message-id:mime-version:references
         :in-reply-to:subject:cc:to:from:date:arc-authentication-results;
        bh=1GiQM2KNiXJ7fDRxYIMFNpSClgzmpwEG3DA6Be32l3w=;
        b=AMbY+8YhYzRLAz+9gI/aIdLw0qCg2s4ZuvG8qXli3IY3dLn46FXpb10Ogvwrt1NfW1
         F2ez1GynFLXHsXqx0Nyw0kCd4b4khPDbUbvyGNhqN8khUzuRS5Jw8Uuuv6vAcX2YcWjx
         twTe3+yW+OfB0FZwB9wpwn0axLfVbqTn6IBM/0JLgwjqt+rzT2C0zKgOI4xShgCfEj0+
         rSSGxObNhtuRZ657ikoAAviRF/yRZiYBZ0Pig8fqAHZPBs/fIvLK49fVIYEzjrQdFaWd
         4AdIw/bZ5VteEenzaNhDypV41Uxj8cPyC4ihdKqhcFWoKSwGtomAO1tXlfABeUfPoI78
         E8/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of schwidefsky@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=schwidefsky@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Date: Mon, 7 May 2018 08:07:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Cornelia Huck
 <cohuck@redhat.com>
Subject: Re: [PATCH 4.4 15/50] s390/alternative: use a copy of the facility
 bit mask
In-Reply-To: <20180504221808.GB24813@kroah.com>
References: <20180427135655.623669681@linuxfoundation.org>
	<20180427135656.637526548@linuxfoundation.org>
	<ded98294-4341-2c96-7ed7-115721af8164@suse.cz>
	<20180504221808.GB24813@kroah.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 18050706-0020-0000-0000-00000419C8C6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050706-0021-0000-0000-000042AEF959
Message-Id: <20180507080707.2a41ae28@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070064
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598908260011997733?=
X-GMAIL-MSGID: =?utf-8?q?1599784340177110131?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 4 May 2018 15:18:08 -0700
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Fri, May 04, 2018 at 09:37:20AM +0200, Jiri Slaby wrote:
> > On 04/27/2018, 03:58 PM, Greg Kroah-Hartman wrote:  
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > 
> > > 
> > > [ Upstream commit cf1489984641369611556bf00c48f945c77bcf02 ]
> > > 
> > > To be able to switch off specific CPU alternatives with kernel parameters
> > > make a copy of the facility bit mask provided by STFLE and use the copy
> > > for the decision to apply an alternative.  
> > ...  
> > > --- a/arch/s390/include/asm/facility.h
> > > +++ b/arch/s390/include/asm/facility.h
> > > @@ -13,6 +13,24 @@
> > >  
> > >  #define MAX_FACILITY_BIT (256*8)	/* stfle_fac_list has 256 bytes */  
> > 
> > I wonder if the below (plus __test_facility) is correct in 4.4, given
> > MAX_FACILITY_BIT is defined as such and not as sizeof(stfle_fac_list *
> > 8) as in upstream?  
> 
> I'm going to defer to Marin here, as he did the backport...
> Martin?

Good catch. With MAX_FACILITY_BIT == 2048 and the patch applied the result
for a test_facility/__test_facility call with a facility number >= 1024
would give an incorrect result. Fortunately there are no such calls in
the current 4.4 kernel source. And there are no facilities defined with
bit numbers this large, so even out-of-tree code would not do this if
it is sane.

To correct this the MAX_FACILITY_BIT define needs to be reduced to 1024
which would require the patch pointed out be Heiko:

commit 6f5165e864d240d15675cc2fb5a369d57e1f60d0
Author: Heiko Carstens <heiko.carstens@de.ibm.com>
Date:   Mon Mar 20 14:29:50 2017 +0100

    s390/facilites: use stfle_fac_list array size for MAX_FACILITY_BIT

I would say yes, it *does* make sense to include this patch even if it
does not fix anything.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
