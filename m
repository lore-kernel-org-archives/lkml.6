Return-Path: <kernel-hardening-return-12275-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtQdidMVddjU6/1gQfRmEpM9LSvbf7j10CNEe7VG/rhvWj1Xmnfod3I9hj02hZsgaNBiKvU
ARC-Seal: i=1; a=rsa-sha256; t=1520548113; cv=none;
        d=google.com; s=arc-20160816;
        b=yzlaAY+EcmJYRUK2j5y+Tq4OSoKDm2rSNeOqxmD81akaS7l/ZHp85myi0G379FAJX0
         j5vrgIsOeAGZnOAr22PdGuqH2KWMUJ8iIUuy1348DA+M2YdlFatGTfwrul9d0To3/qia
         B4rzERizr4lWg8WVp0dwonI1h83Rlsv0XPFmbfDzWs7xmwGj5p195Kdyq8kFgBghgJtE
         4S98X2nlhO0auIG9OJ2SX+w7P/XzBH+vJNTWVf1nUAUjb1SQBWdAQxREO95m/C/vgT2j
         +Y2TKQ9dWHN6yd8vgIQoOI7U5gC6L1AKnG2dDTI1PpafigGPdpgp1u8YSXwcG23pV9Cx
         o/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=kv11oOJpjmYvtwrBdA/bYGZyRaGRG199BQYDvtlP56M=;
        b=Ow+xxUPjv/1TlgHgXYEZ7jGOoNKkhjq7e5xIEDUM5cFqT3AjNgFqxtZrR/FRzAio+8
         Sk3lGtlTtrvvK5Js0+IKiBPQ4dBo5PzHbLmkdPNYktP075GjYL91YzG0kCUKxezr+n8+
         gAwy1MBsRh2hn+QDqBZij6uc8+XRQ0F/PxvkdCp93uZTx8WR3Eg0dc8b7V2aqqtgLwTn
         1FQaTAPNZRU+3gBhoh50PS2jj5+jRC64V1tUV5s3DIB0JmZp7BHOvUcEpTAEi1kSDloT
         rKu0HCCBg+22bVy9BTm+xvcGXWUbVDjkYli4MqUq2ZRQ1ir3XBct/+bW9jtJ807Zs6Fx
         8qcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12275-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12275-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12275-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12275-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH v2] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date: Thu, 08 Mar 2018 17:28:06 -0500
In-Reply-To: <20180308221537.46ogqx64cev767ur@smitten>
References: <20180308202347.31331-1-tycho@tycho.ws>
	 <1520541374.3605.101.camel@linux.vnet.ibm.com>
	 <20180308214547.kdeoeozugxffzumn@smitten>
	 <1520546740.3605.124.camel@linux.vnet.ibm.com>
	 <20180308221537.46ogqx64cev767ur@smitten>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030822-0016-0000-0000-0000052E9653
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030822-0017-0000-0000-0000286BB7F9
Message-Id: <1520548086.3605.135.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080241
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594402547592935810?=
X-GMAIL-MSGID: =?utf-8?q?1594410258460789460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-08 at 15:15 -0700, Tycho Andersen wrote:
> Hi Mimi,
> 
> On Thu, Mar 08, 2018 at 05:05:40PM -0500, Mimi Zohar wrote:
> > On Thu, 2018-03-08 at 14:45 -0700, Tycho Andersen wrote:
> > > Hi Mimi,
> > > 
> > > On Thu, Mar 08, 2018 at 03:36:14PM -0500, Mimi Zohar wrote:
> > > > On Thu, 2018-03-08 at 13:23 -0700, Tycho Andersen wrote:
> > > > 
> > > > >  /*
> > > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > > > > index 2cfb0c714967..356faae6f09c 100644
> > > > > --- a/security/integrity/ima/ima_main.c
> > > > > +++ b/security/integrity/ima/ima_main.c
> > > > > @@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
> > > > >  					      xattr_value, xattr_len, opened);
> > > > >  		inode_unlock(inode);
> > > > >  	}
> > > > > -	if (action & IMA_AUDIT)
> > > > > -		ima_audit_measurement(iint, pathname);
> > > > > +	if (action & IMA_AUDIT) {
> > > > > +		rc = ima_audit_measurement(iint, pathname);
> > > > > +		if (rc < 0)
> > > > > +			goto out_locked;
> > > > > +	}
> > > > > 
> > > > >  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
> > > > >  		rc = 0;
> > > > 
> > > > Only when IMA-appraisal is enforcing file data integrity should
> > > > process_measurement() ever fail.  Other errors can be logged/audited.
> > > 
> > > Ok, so previously in ima_audit_measurement() when allocation failed,
> > > there was nothing logged. If we just keep this behavior like below,
> > > does that look good?
> > 
> > Before the IMA locking change that were just upstreamed, there were
> > problems with measuring/appraising files that were opened with the
> > O_DIRECT flag.  Unless the IMA policy specified permit_directio, the
> > measurement/appraisal failed.  With the new locking, opening files
> > with the O_DIRECTIO flag shouldn't be a problem.  It just needs to be
> > fully tested before removing this code.
> > 
> > On failure, the code below tests the ima_audit_measurement() result
> > and skips the IMA_PERMIT_DIRECTIO test.  Unless I'm missing something,
> > I don't see the point.
> 
> It skips the IMA_PERMIT_DIRECTIO test because it's already going to
> fail: we're in enforce mode and we got an allocation failure and so we
> can't audit this access (note: there is another allocation failure in
> ima_audit_measurement() which is still ignored after this patch, so
> maybe ignoring failures is ok; seems like it's not, though

By the time we get here, we've already verified the file's integrity,
if it is in policy.  At this point, we're attempting to add the file
hash to the audit log.  If for some reason the audit fails, there's
not much we can do.

> I'm not sure I really understand the rest of your message though. Can
> you suggest what the patch should do here? Should we just ignore all
> failures as before?

I would leave it as it is.

Mimi
 
