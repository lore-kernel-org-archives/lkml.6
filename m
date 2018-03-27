Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AG47ELuQUHwvzAEU0rFRQFTmpLX2Yxy/TqmydZOQOVDhXXpjOpt7tPvyzo/AEmDR8MBcpKoLVUmW
ARC-Seal: i=1; a=rsa-sha256; t=1522134400; cv=none;
        d=google.com; s=arc-20160816;
        b=zyuFTuijaDuyKanjMcqA6Yo9xo0lV9/p95c7nOZV5gB6gb8AV1pkZJr7xSg3Y6pWjD
         zY5cKGgB5WvbyC0D/bQ2sKqohWIo6CjSnKK3mDlediwS9ClSGHAGo1s/DuwR2oQXh9qT
         iyql9QVnum8pz/x14sggMyOAgCUQUgNu3L86Pb2PyW3UtPqJpzDXrLlVJ6AcIEWGcc5x
         nLrblPJfaOFjc7OrPFDyxwWqMZOLVLrPD+viQ8fti9Ct+Cn0bTY5XdHXAmqYKxUSXWaZ
         g40NKyC83F8lTdGqbk5/hXoXfX2JX4gLcrW/zYFHbaP4uURiSkpbVHPCbbuiC1z2fDE0
         K87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=BYNO4MOnGWcg5XpTsPVHXhHXtTSIaL5TLfXujGqEMTs=;
        b=XO1guhhH/KQXPWiLej+iLpELhH/yw3EZGj49lfMZKpq73NVqxUYzi7YzceNgxfu+IR
         P9wVfJVB2DW16XsJpW9tz8ToS/rVyKz7kx+c5ECS7mpYPWBfAL28XfyZufaRIMC4uofQ
         dCau/5bmIELxD0dixrNVW/iYsiC2CEFro7uGoI4bm7VxY570OHDIMDLNRB+lc1xG1Uh8
         CHpPWFEIWn+tl0ciozKBcO91WrJY20+N9PNGuHfUZTZQJ5OJCucezU2ngDrJSshsZWjn
         Gkp6uTMoXrcNzruWFuBjFbYNRKX7xB4B/rGdjhmDSSfW3VM0UvyDAGNtuHxgOVtRCJ/D
         dPIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Tue, 27 Mar 2018 09:06:37 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>, xfs <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Josh Triplett <josh@joshtriplett.org>, Takashi Iwai <tiwai@suse.de>,
	Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] xfs: always free inline data before resetting inode fork
 during ifree
Message-ID: <20180327070637.GX5652@dhcp22.suse.cz>
References: <20171123060137.GL2135@magnolia>
 <20180323013037.GA9190@wotan.suse.de>
 <20180323034145.GH4818@magnolia>
 <20180323170813.GD30543@wotan.suse.de>
 <20180323172620.GK4818@magnolia>
 <20180323182302.GB9190@wotan.suse.de>
 <20180325223357.GJ18129@dastard>
 <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1xoqdWBumgCn9iw7FH_6VtDnEmd5_Hyw=cY4b9zB=Avhx-4g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595753768288631831?=
X-GMAIL-MSGID: =?utf-8?q?1596073600781521309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-03-18 19:54:31, Sasha Levin wrote:
[...]
> About half a year ago. I'm not sure about the no visibility part -
> maintainers and authors would receive at least 3 mails for each patch
> that got in this way, and would have at least a week (usually a lot
> more) to object to the inclusion. Did you not receive any mails from
> me?

Well, I was aware of your emails yet my free time didn't really allow me
to follow those patch bombs. I responded only when some email subject
hit my eyes as being non-stable candidate. So by no means the MM
backports were reviewed by me. And considering how hard it is to get any
review for MM patches in general I strongly suspect that others didn't
review either.

In general I am quite skeptical about the automagic backports
selections, to be honest. MM patches should be reasonably good at
selecting stable backports and adding more patches on top just risks
regressions. 
-- 
Michal Hocko
SUSE Labs
