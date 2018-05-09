Return-Path: <linux_dti@icloud.com>
X-Google-Smtp-Source: AB8JxZpO/AsPWXNCRtnh38a073ldMMfeX3CCSgfvfPqOyoH6+E1hYx7PgRrabgDLZqJBjwnO6xUu
ARC-Seal: i=1; a=rsa-sha256; t=1525851314; cv=none;
        d=google.com; s=arc-20160816;
        b=Sk0li460Wa/DDvbzqdHklB0m9j0ffme+95PwAXJ9FEirYJoAWQB57i1HqbBMgXjluF
         t6jYOSoJFxc2zOC5gIlHA7AzZFP19/hWjK+TdYdYt/jaaWB9iTe5+On+fQWilGKUPGiL
         s+MzzNBk1zPlFPNxWJOJkxabxCdUFDRoOu2steg2ZXrEby98G+vJg6eukj1NAFGN9Z34
         ZZKrhqgKM6Uc9Qgv3uc4ZcNFCfoLHYeflR0rWJSQrAVHk6+uHDbiwmE9xZPb4WoXUjml
         ULZSPAg+5js8PPXI6hVmqCdTvnOLD7gA2Ghu6vAnxrKdYyKZZ6EetIhTiivAGiWMKD/G
         WDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=GGdE7mD/KhdNxUz2MmyDTf9HyB04axmN4LkGOy5nXV8=;
        b=F70RNUFblzvkZlKR/qKRQsharuz7ojNlcxhi/1Zykcz2FzLeN/IxDxdcUmHuv6eoJq
         Ev4hhX+q6t9/2zJVzTjkRWEb3odR3eX1teIZ7VUpEc+c9sSKY8CuQIWuzEraN6ZPnsn4
         R5DttEcO6PxV5is1T03XAyLCianv0Bx871JZXYOmnHt5AWdMHWcUtqf2MQ5TBIR2Lbrs
         Ia75dfaeCzjh7yJy2kVjgUWpUqsvEbz34kosYfHk8rOoWvoa1GZUBlkij/wuOdqEiXUW
         Pwb2yH1jq0M7sSAsShWT0+CeBeL3U54ljO+IFSkbMw0F5s2HAaViDPBSKMkwCQPxXvYE
         Iw0Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=AxcqWCR6;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.38 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=AxcqWCR6;
       spf=pass (google.com: domain of linux_dti@icloud.com designates 17.58.37.38 as permitted sender) smtp.mailfrom=linux_dti@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-09_02:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805090075
Date: Wed, 09 May 2018 09:35:04 +0200
From: damian <linux_dti@icloud.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, damian <damian.tometzki@icloud.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-id: <20180509073503.GA2116@zrhn9910b>
Mail-followup-to: Josh Poimboeuf <jpoimboe@redhat.com>,
 Greg KH <gregkh@linuxfoundation.org>, damian <damian.tometzki@icloud.com>,
 peterz@infradead.org, linux-kernel@vger.kernel.org
References: <20180505192112.GA18728@zrhn9910b>
 <20180507045453.leou4zypnlcck4vr@treble> <20180508055126.GA18724@kroah.com>
 <20180508133226.uwjbx44fwlxgyzu5@treble> <20180508142515.GA16111@kroah.com>
 <20180508143241.5kz4poxcdhajjorl@treble>
 <20180509034646.7qftdvummkz7b2pi@treble>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20180509034646.7qftdvummkz7b2pi@treble>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599903094060891144?=
X-GMAIL-MSGID: =?utf-8?q?1599971068544688412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Josh,

i tested the patch on my maschine it works fine. 

Best regards
Damian

On Tue, 08. May 22:46, Josh Poimboeuf wrote:
> On Tue, May 08, 2018 at 09:32:41AM -0500, Josh Poimboeuf wrote:
> > On Tue, May 08, 2018 at 04:25:15PM +0200, Greg KH wrote:
> > > Much nicer, thanks for the patch, seems to build things "quieter" now.
> > > For the other warnings, they are "safe" to ignore, right?  It's just
> > > objtool checking to see if all is ok, but the result should be fine no
> > > matter what, right?
> > 
> > Yeah, from what I can tell, there's nothing catastrophic in the rest of
> > the warnings.  Worst case, the ORC unwinder might get confused in a few
> > places.
> 
> FWIW, here's the latest version of the patch.  This fixes all the
> warnings on my config at least.  I'll be sending it to -tip soon if it
> survives 0-day testing.
> 
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] objtool: Detect GCC 8 cold subfunctions
> 
> GCC 8 moves a lot of unlikely code out of line to "cold" subfunctions in
> .text.unlikely.  Properly detect the new subfunctions and treat them as
> extensions of the original functions.
> 
> This fixes a bunch of warnings like:
> 
>   kernel/cgroup/cgroup.o: warning: objtool: parse_cgroup_root_flags()+0x33: sibling call from callable instruction with modified stack frame
>   kernel/cgroup/cgroup.o: warning: objtool: cgroup_addrm_files()+0x290: sibling call from callable instruction with modified stack frame
>   kernel/cgroup/cgroup.o: warning: objtool: cgroup_apply_control_enable()+0x25b: sibling call from callable instruction with modified stack frame
>   kernel/cgroup/cgroup.o: warning: objtool: rebind_subsystems()+0x325: sibling call from callable instruction with modified stack frame
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  tools/objtool/check.c | 104 +++++++++++++++++++++++++-----------------
>  tools/objtool/elf.c   |  42 ++++++++++++++++-
>  tools/objtool/elf.h   |   2 +
>  3 files changed, 104 insertions(+), 44 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 264522d4e4af..ee72958d3464 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -59,6 +59,31 @@ static struct instruction *next_insn_same_sec(struct objtool_file *file,
>  	return next;
>  }
>  
> +static struct instruction *next_insn_same_func(struct objtool_file *file,
> +					       struct instruction *insn)
> +{
> +	struct instruction *next = list_next_entry(insn, list);
> +	struct symbol *func = insn->func;
> +
> +	if (!func)
> +		return NULL;
> +
> +	if (&next->list != &file->insn_list && next->func == func)
> +		return next;
> +
> +	/* Check if we're already in the subfunction: */
> +	if (func == func->cfunc)
> +		return NULL;
> +
> +	/* Move to the subfunction: */
> +	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
> +}
> +
> +#define func_for_each_insn_all(file, func, insn)			\
> +	for (insn = find_insn(file, func->sec, func->offset);		\
> +	     insn;							\
> +	     insn = next_insn_same_func(file, insn))
> +
>  #define func_for_each_insn(file, func, insn)				\
>  	for (insn = find_insn(file, func->sec, func->offset);		\
>  	     insn && &insn->list != &file->insn_list &&			\
> @@ -149,10 +174,14 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
>  			if (!strcmp(func->name, global_noreturns[i]))
>  				return 1;
>  
> -	if (!func->sec)
> +	if (!func->len)
>  		return 0;
>  
> -	func_for_each_insn(file, func, insn) {
> +	insn = find_insn(file, func->sec, func->offset);
> +	if (!insn->func)
> +		return 0;
> +
> +	func_for_each_insn_all(file, func, insn) {
>  		empty = false;
>  
>  		if (insn->type == INSN_RETURN)
> @@ -167,28 +196,17 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
>  	 * case, the function's dead-end status depends on whether the target
>  	 * of the sibling call returns.
>  	 */
> -	func_for_each_insn(file, func, insn) {
> -		if (insn->sec != func->sec ||
> -		    insn->offset >= func->offset + func->len)
> -			break;
> -
> +	func_for_each_insn_all(file, func, insn) {
>  		if (insn->type == INSN_JUMP_UNCONDITIONAL) {
>  			struct instruction *dest = insn->jump_dest;
> -			struct symbol *dest_func;
>  
>  			if (!dest)
>  				/* sibling call to another file */
>  				return 0;
>  
> -			if (dest->sec != func->sec ||
> -			    dest->offset < func->offset ||
> -			    dest->offset >= func->offset + func->len) {
> -				/* local sibling call */
> -				dest_func = find_symbol_by_offset(dest->sec,
> -								  dest->offset);
> -				if (!dest_func)
> -					continue;
> +			if (dest->func && dest->func->pfunc != insn->func->pfunc) {
>  
> +				/* local sibling call */
>  				if (recursion == 5) {
>  					/*
>  					 * Infinite recursion: two functions
> @@ -199,7 +217,7 @@ static int __dead_end_function(struct objtool_file *file, struct symbol *func,
>  					return 0;
>  				}
>  
> -				return __dead_end_function(file, dest_func,
> +				return __dead_end_function(file, dest->func,
>  							   recursion + 1);
>  			}
>  		}
> @@ -426,7 +444,7 @@ static void add_ignores(struct objtool_file *file)
>  			if (!ignore_func(file, func))
>  				continue;
>  
> -			func_for_each_insn(file, func, insn)
> +			func_for_each_insn_all(file, func, insn)
>  				insn->ignore = true;
>  		}
>  	}
> @@ -786,30 +804,28 @@ static int add_special_section_alts(struct objtool_file *file)
>  	return ret;
>  }
>  
> -static int add_switch_table(struct objtool_file *file, struct symbol *func,
> -			    struct instruction *insn, struct rela *table,
> -			    struct rela *next_table)
> +static int add_switch_table(struct objtool_file *file, struct instruction *insn,
> +			    struct rela *table, struct rela *next_table)
>  {
>  	struct rela *rela = table;
>  	struct instruction *alt_insn;
>  	struct alternative *alt;
> +	struct symbol *pfunc = insn->func->pfunc;
> +	unsigned int prev_offset = 0;
>  
>  	list_for_each_entry_from(rela, &file->rodata->rela->rela_list, list) {
>  		if (rela == next_table)
>  			break;
>  
> -		if (rela->sym->sec != insn->sec ||
> -		    rela->addend <= func->offset ||
> -		    rela->addend >= func->offset + func->len)
> +		if (prev_offset && rela->offset != prev_offset + sizeof(long))
>  			break;
>  
> -		alt_insn = find_insn(file, insn->sec, rela->addend);
> -		if (!alt_insn) {
> -			WARN("%s: can't find instruction at %s+0x%x",
> -			     file->rodata->rela->name, insn->sec->name,
> -			     rela->addend);
> -			return -1;
> -		}
> +		alt_insn = find_insn(file, rela->sym->sec, rela->addend);
> +		if (!alt_insn)
> +			break;
> +
> +		if (alt_insn->func->pfunc != pfunc)
> +			break;
>  
>  		alt = malloc(sizeof(*alt));
>  		if (!alt) {
> @@ -819,6 +835,13 @@ static int add_switch_table(struct objtool_file *file, struct symbol *func,
>  
>  		alt->insn = alt_insn;
>  		list_add_tail(&alt->list, &insn->alts);
> +		prev_offset = rela->offset;
> +	}
> +
> +	if (!prev_offset) {
> +		WARN_FUNC("can't find switch jump table",
> +			  insn->sec, insn->offset);
> +		return -1;
>  	}
>  
>  	return 0;
> @@ -947,7 +970,7 @@ static int add_func_switch_tables(struct objtool_file *file,
>  	struct rela *rela, *prev_rela = NULL;
>  	int ret;
>  
> -	func_for_each_insn(file, func, insn) {
> +	func_for_each_insn_all(file, func, insn) {
>  		if (!last)
>  			last = insn;
>  
> @@ -978,8 +1001,7 @@ static int add_func_switch_tables(struct objtool_file *file,
>  		 * the beginning of another switch table in the same function.
>  		 */
>  		if (prev_jump) {
> -			ret = add_switch_table(file, func, prev_jump, prev_rela,
> -					       rela);
> +			ret = add_switch_table(file, prev_jump, prev_rela, rela);
>  			if (ret)
>  				return ret;
>  		}
> @@ -989,7 +1011,7 @@ static int add_func_switch_tables(struct objtool_file *file,
>  	}
>  
>  	if (prev_jump) {
> -		ret = add_switch_table(file, func, prev_jump, prev_rela, NULL);
> +		ret = add_switch_table(file, prev_jump, prev_rela, NULL);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1753,15 +1775,13 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  	while (1) {
>  		next_insn = next_insn_same_sec(file, insn);
>  
> -
> -		if (file->c_file && func && insn->func && func != insn->func) {
> +		if (file->c_file && func && insn->func && func != insn->func->pfunc) {
>  			WARN("%s() falls through to next function %s()",
>  			     func->name, insn->func->name);
>  			return 1;
>  		}
>  
> -		if (insn->func)
> -			func = insn->func;
> +		func = insn->func ? insn->func->pfunc : NULL;
>  
>  		if (func && insn->ignore) {
>  			WARN_FUNC("BUG: why am I validating an ignored function?",
> @@ -1782,7 +1802,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  
>  				i = insn;
>  				save_insn = NULL;
> -				func_for_each_insn_continue_reverse(file, func, i) {
> +				func_for_each_insn_continue_reverse(file, insn->func, i) {
>  					if (i->save) {
>  						save_insn = i;
>  						break;
> @@ -1869,7 +1889,7 @@ static int validate_branch(struct objtool_file *file, struct instruction *first,
>  		case INSN_JUMP_UNCONDITIONAL:
>  			if (insn->jump_dest &&
>  			    (!func || !insn->jump_dest->func ||
> -			     func == insn->jump_dest->func)) {
> +			     insn->jump_dest->func->pfunc == func)) {
>  				ret = validate_branch(file, insn->jump_dest,
>  						      state);
>  				if (ret)
> @@ -2064,7 +2084,7 @@ static int validate_functions(struct objtool_file *file)
>  
>  	for_each_sec(file, sec) {
>  		list_for_each_entry(func, &sec->symbol_list, list) {
> -			if (func->type != STT_FUNC)
> +			if (func->type != STT_FUNC || func->pfunc != func)
>  				continue;
>  
>  			insn = find_insn(file, sec, func->offset);
> diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
> index c1c338661699..4e60e105583e 100644
> --- a/tools/objtool/elf.c
> +++ b/tools/objtool/elf.c
> @@ -79,6 +79,19 @@ struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
>  	return NULL;
>  }
>  
> +struct symbol *find_symbol_by_name(struct elf *elf, const char *name)
> +{
> +	struct section *sec;
> +	struct symbol *sym;
> +
> +	list_for_each_entry(sec, &elf->sections, list)
> +		list_for_each_entry(sym, &sec->symbol_list, list)
> +			if (!strcmp(sym->name, name))
> +				return sym;
> +
> +	return NULL;
> +}
> +
>  struct symbol *find_symbol_containing(struct section *sec, unsigned long offset)
>  {
>  	struct symbol *sym;
> @@ -203,10 +216,11 @@ static int read_sections(struct elf *elf)
>  
>  static int read_symbols(struct elf *elf)
>  {
> -	struct section *symtab;
> -	struct symbol *sym;
> +	struct section *symtab, *sec;
> +	struct symbol *sym, *pfunc;
>  	struct list_head *entry, *tmp;
>  	int symbols_nr, i;
> +	char *coldstr;
>  
>  	symtab = find_section_by_name(elf, ".symtab");
>  	if (!symtab) {
> @@ -281,6 +295,30 @@ static int read_symbols(struct elf *elf)
>  		hash_add(sym->sec->symbol_hash, &sym->hash, sym->idx);
>  	}
>  
> +	/* Create parent/child links for any cold subfunctions */
> +	list_for_each_entry(sec, &elf->sections, list) {
> +		list_for_each_entry(sym, &sec->symbol_list, list) {
> +			if (sym->type != STT_FUNC)
> +				continue;
> +			sym->pfunc = sym->cfunc = sym;
> +			coldstr = strstr(sym->name, ".cold.");
> +			if (coldstr) {
> +				coldstr[0] = '\0';
> +				pfunc = find_symbol_by_name(elf, sym->name);
> +				coldstr[0] = '.';
> +
> +				if (!pfunc) {
> +					WARN("%s(): can't find parent function",
> +					     sym->name);
> +					goto err;
> +				}
> +
> +				sym->pfunc = pfunc;
> +				pfunc->cfunc = sym;
> +			}
> +		}
> +	}
> +
>  	return 0;
>  
>  err:
> diff --git a/tools/objtool/elf.h b/tools/objtool/elf.h
> index d86e2ff14466..de5cd2ddded9 100644
> --- a/tools/objtool/elf.h
> +++ b/tools/objtool/elf.h
> @@ -61,6 +61,7 @@ struct symbol {
>  	unsigned char bind, type;
>  	unsigned long offset;
>  	unsigned int len;
> +	struct symbol *pfunc, *cfunc;
>  };
>  
>  struct rela {
> @@ -86,6 +87,7 @@ struct elf {
>  struct elf *elf_open(const char *name, int flags);
>  struct section *find_section_by_name(struct elf *elf, const char *name);
>  struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
> +struct symbol *find_symbol_by_name(struct elf *elf, const char *name);
>  struct symbol *find_symbol_containing(struct section *sec, unsigned long offset);
>  struct rela *find_rela_by_dest(struct section *sec, unsigned long offset);
>  struct rela *find_rela_by_dest_range(struct section *sec, unsigned long offset,
> -- 
> 2.17.0
> 
