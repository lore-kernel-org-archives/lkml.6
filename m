Return-Path: <knut.omang@oracle.com>
X-Google-Smtp-Source: AH8x227tQkdQycWiaUTHzDDiChb670G/nb9yI0iH52DMChmC4wjxo4G+qrG6D/ErNvTXZl7IyR41
ARC-Seal: i=1; a=rsa-sha256; t=1517569487; cv=none;
        d=google.com; s=arc-20160816;
        b=twlX6lHiY4yjMomBV4lYV/rdTQUrBrK10sVkBIX/yiE5T+3hAN3Z+RYGpuuOt9BdEG
         J9MvimyPWMgo+IBOSOYT/G2YW9o01b24ydlB61C/by5WwZ7O6BkdoFVnDEaI2rHHSClt
         ku3j1IpVlsSY2z/d1zbLzARWLnsSZfhjBF6OZWUpNnHLPrDlEIQ/QfVXX/GgsTcFzApV
         yO6xyWhQoG6WPyurL+TWER1b0DaZySQlW7FbF/m1fzDFzs935yN3vGPe1Xh5nHfqL2PI
         7W8RzPGsOR47Wadbzq0uB6FQyL4lJAFm90Xr7s7RnH3yQfaVm+b2mh+J8N6zS7KHYQBM
         lYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=N9b2tttdUgqNfYD9+VgLWyu9u0Wo8ao0YyeJONxiBTo=;
        b=Vto9FB8nfSEDQHC9EujiostJ/tXbbLQ+CEd2NAtEdpjIJyldiKpQm+sCZLvAdhtkZl
         LRewv9q38ZYcFBPiOkcKSDQdsuTgi5FxmjUxR5HreMENHj3FHfHXYLtdh1lMWZEFuwDY
         Y5j+keRmzCFYeBeda9duJ+AtaCQWq8vYBUnmod+L+tm81vLS8yTjJCNItcEXsIi/FpsJ
         29O3MnvJfHOMlxl9B5OYoAfsmPCkBBdLnekurH+cJeYUO5qVyf9jgoz0GB3+0on7oTPE
         gqKFrP73Edy0rQ/aX5iQrydJU3LylPZQuFV9xWbK96G99DDzGvovZOHxaTk0ThMVdNet
         a9wg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tF1DASJZ;
       spf=pass (google.com: domain of knut.omang@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=knut.omang@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=tF1DASJZ;
       spf=pass (google.com: domain of knut.omang@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=knut.omang@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Message-ID: <1517569472.3118.257.camel@oracle.com>
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
From: Knut Omang <knut.omang@oracle.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
        Greg KH
	 <gregkh@linuxfoundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Ozan Alpay <ozyalpy@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
	 <ville.syrjala@linux.intel.com>,
        sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org,
        David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen
	 <joonas.lahtinen@linux.intel.com>,
        llvmlinux@lists.linuxfoundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Date: Fri, 02 Feb 2018 12:04:32 +0100
In-Reply-To: <87h8qzisbt.fsf@intel.com>
References: <alpine.DEB.2.20.1802011823340.4316@alpaca>
	 <20180201180240.GA28042@kroah.com>
	 <alpine.DEB.2.20.1802012045570.29994@hsp> <87372jkcu5.fsf@intel.com>
	 <alpine.DEB.2.20.1802021054500.13838@hsp>
	 <20180202100613.GA21492@kroah.com> <87h8qzisbt.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020136
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591285684265715697?=
X-GMAIL-MSGID: =?utf-8?q?1591286942972031121?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 12:44 +0200, Jani Nikula wrote:
> +Knut, Fengguang
> 
> On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 	- If clang now builds the kernel "cleanly", yes, I want to take
> > 	  warning fixes in the stable tree.  And even better yet, if you
> > 	  keep working to ensure the tree is "clean", that would be
> > 	  wonderful.
> 
> So we can run sparse using 'make C=1' and friends, or other static
> analysis tools using 'make CHECK=foo C=1', as long as the passed command
> line params work. There was work by Knut to extend this make checker
> stuff [1]. Since mixing different HOSTCC's in a single workdir seems
> like a bad idea, I wonder how hard it would be to make clang work like
> this:
> 
> $ make CHECK=clang C=1
> 
> Or using Knut's wrapper. Feels like that could increase the use of clang
> for static analysis of patches.

Yes, definitely a natural addition to the set of tools supported by
runchecks to also support using alternate compiler(s) as "checkers" - I guess
the same would apply for people compiling with clang - that they don't accidentally
generate warnings with gcc..

Thanks,
Knut

> BR,
> Jani.
> 
> 
> [1] http://mid.mail-archive.com/cover.5b56d020b8e826a7da33b1823c059acd0c123f8b.151507278
> 2.git-series.knut.omang@oracle.com
> 
> 
> 
