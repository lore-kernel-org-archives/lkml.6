Return-Path: <jani.nikula@intel.com>
X-Google-Smtp-Source: AH8x226uhhS3EI9dzyVz4jv2K+QC0WCMVVP++QoEahO/pO7AKmC+mrXUuGe8cEkFyVjDzvlnfgGP
ARC-Seal: i=1; a=rsa-sha256; t=1517568286; cv=none;
        d=google.com; s=arc-20160816;
        b=FOcHNMeDD3MIMiXL7E5qm9NWKQ3PjXf9Zv9x7gY/AMtUDpBVjluKI4JTs8S7zr4Xwg
         aMMK7H9a51tB1eV4mmW847i2bkhfQuxpUtTu+frLXv4ZDtloDOjffwsR1hAqUbNSuarU
         q/Pc1qjWQbX3epAeomppQi6+c1gTGXz09zRcnzCCpukpQrCb3aAv6K4ctDc9aZTyK4Mc
         6y2sD2oAJUhT6Oa1ubXj3loo/G782BEnnViVNJpvKG32tvsW5neEpNGAmtEsimtq8TA3
         frmbuPLWwrXfRHAfuW6vI+uCsOsXpmWy2rCYF5p7KcIvW2dHqFyxadPMjjadpRop097i
         XW6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:organization:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=msf/sUVoRQ/JGnBGT5TJc/imKlS5ELMxlJA4B5SeTnU=;
        b=qQyWfyUFJVHLCNqQEWVbYm82aPcZfGHxcNQVUm5l1n9zYd4m7mOytRybxsjQpGL/Vz
         s9qRIb8C6WWAxGqAix/2DkBXBKQ27MvaAUtR8M0GwOonx6cPch0P2Hn3IGMRdsPelRr7
         ZUrDSad8KNpXS/MOvxX1yJxSEQQ7/1G+9FFDlrcQgKLBxjlN71JBTRsedyihTQZHgUtC
         mweWTx0sA0lc9NFuDVsR29ss3mRz/uf4oQjavq5ECGdh3H4Bj2iaFP02fwopXUuWlptY
         Vda046juqrkfd3W+WVt/Oax+GX2BD9e+WKizJvKip3tNeCZ8rFSDIXL8xXIt6vL4YrOm
         0/9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 134.134.136.20 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,448,1511856000";
   d="scan'208";a="27511184"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Knut Omang <knut.omang@oracle.com>
Cc: Ozan Alpay <ozyalpy@gmail.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 sil2review@lists.osadl.org, kernelnewbies@kernelnewbies.org, David Airlie
 <airlied@linux.ie>, intel-gfx@lists.freedesktop.org, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, llvmlinux@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: clang warning: implicit conversion in intel_ddi.c:1481
In-Reply-To: <20180202100613.GA21492@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <alpine.DEB.2.20.1802011823340.4316@alpaca> <20180201180240.GA28042@kroah.com> <alpine.DEB.2.20.1802012045570.29994@hsp> <87372jkcu5.fsf@intel.com> <alpine.DEB.2.20.1802021054500.13838@hsp> <20180202100613.GA21492@kroah.com>
Date: Fri, 02 Feb 2018 12:44:38 +0200
Message-ID: <87h8qzisbt.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1591285684265715697?=
X-GMAIL-MSGID: =?utf-8?q?1591285684265715697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


+Knut, Fengguang

On Fri, 02 Feb 2018, Greg KH <gregkh@linuxfoundation.org> wrote:
> 	- If clang now builds the kernel "cleanly", yes, I want to take
> 	  warning fixes in the stable tree.  And even better yet, if you
> 	  keep working to ensure the tree is "clean", that would be
> 	  wonderful.

So we can run sparse using 'make C=1' and friends, or other static
analysis tools using 'make CHECK=foo C=1', as long as the passed command
line params work. There was work by Knut to extend this make checker
stuff [1]. Since mixing different HOSTCC's in a single workdir seems
like a bad idea, I wonder how hard it would be to make clang work like
this:

$ make CHECK=clang C=1

Or using Knut's wrapper. Feels like that could increase the use of clang
for static analysis of patches.


BR,
Jani.


[1] http://mid.mail-archive.com/cover.5b56d020b8e826a7da33b1823c059acd0c123f8b.1515072782.git-series.knut.omang@oracle.com



-- 
Jani Nikula, Intel Open Source Technology Center
