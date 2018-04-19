Date: Thu, 19 Apr 2018 08:38:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nadav Amit <namit@vmware.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Xavier Deguillard <xdeguillard@vmware.com>,
	pv-drivers <pv-drivers@vmware.com>,
	LKML <linux-kernel@vger.kernel.org>, Gil Kupfer <gilkup@gmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"ldu@redhat.com" <ldu@redhat.com>,
	Oleksandr Natalenko <oleksandr@redhat.com>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Message-ID: <20180419063856.GA7643@kroah.com>
References: <20180312191917.21381-1-namit@vmware.com>
 <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
 <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
 <CAHcwAbSijSmeU3WnznAC+ZaF9iCmYkizqiJNuvLcrYm-YCWxRg@mail.gmail.com>
 <219A03D6-7375-4577-90BA-45DCF2A29289@vmware.com>
 <CAHcwAbQ4y3vWp7p7GayfdbzbomLrqLKMfu0egEoEODJ3LN5qOw@mail.gmail.com>
 <CAHcwAbTEjs6+oPYRJ1HTj--Xh6tORygYUL6aU9tMOJ1KHP_eKQ@mail.gmail.com>
 <A518FF77-554C-40E0-8656-5BEFA57C7A8E@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A518FF77-554C-40E0-8656-5BEFA57C7A8E@vmware.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 05:54:21PM +0000, Nadav Amit wrote:
> Oleksandr Natalenko <oleksandr@redhat.com> wrote:
> 
> > Hello.
> > 
> > On Fri, Mar 23, 2018 at 9:42 AM, Oleksandr Natalenko
> > <oleksandr@redhat.com> wrote:
> >>> Actually, rechecking the bug description, I might have rushed. The bug that
> >>> I encountered is related to the vunmap() but it is only caused when batching
> >>> is off, while the bug you reported has batching on.
> >>> 
> >>> It seems that your sources support batching but do not include b91f108a3d54
> >>> (“VMware balloon: Treat init like reset”), which I think would have solved
> >>> the problem. I don’t see a mainline kernel that supports batching and does
> >>> not have this patch, so it would be helpful to see the exact module that you
> >>> use.
> >> 
> >> Correct. The hash is d7568c130d0d0ff1fc5b364fc879b91f108a3d54, actually, though.
> >> Yes, we miss this commit in our code base, but also we've already
> >> provided a test kernel
> >> with this commit included to the customer. Unfortunately, we have no answer yet.
> > 
> > At least for one customer I can confirm that the kernel built with
> > both d7568c130 and the proposed patch fixes the issue.
> 
> Greg,
> 
> Can you commit please this patch? Preferably for 4.17?
> 
> There is one minor mistake in the commit message - this patch fixes
> f220a80f0c2e and not as written. Please let me know if you want a v3 or can
> amend it while committing.

Please resend, never make a maintainer have to hand-edit a patch.

thanks,

greg k-h
