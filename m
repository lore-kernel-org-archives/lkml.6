Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEVDdZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:33:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52418 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeEVDdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:33:21 -0400
X-Google-Smtp-Source: AB8JxZoo+DNdwxnxoXgh7hpgML6oHsnshlwlCB62KOzuuTzXZQiny8HqeuDL0TeITszQYFOC0z5ClQ==
MIME-Version: 1.0
From: user1 <user1@hyperlinux.info>
Date: Tue, 22 May 2018 12:32:44 +0900
X-Gmail-Original-Message-ID: <CANJtJ6HOevqOvkL+ka9NCZ5v0qR82TW6r-FhN1sL-b_2Ux4kMA@mail.gmail.com>
Message-ID: <CANJtJ6HOevqOvkL+ka9NCZ5v0qR82TW6r-FhN1sL-b_2Ux4kMA@mail.gmail.com>
Subject: [PATCH] scripts/kconfig/confdata.c: Fix script/checkpatch.pl coding
 style issues.
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I fixed the coding style issus in scripts/kconfig/confdata.c to not get
errors at least.

Signed-off-by:  user1 <user1@hyperlinux.info>

---
  scripts/kconfig/confdata.c | 110 ++++++++++++++++++++-----------------
  1 file changed, 60 insertions(+), 50 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index df26c7b0fe13..d978ed1588e6 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -50,7 +50,7 @@ static void conf_default_message_callback(const char
*fmt, va_list ap)
      printf("\n#\n");
  }

-static void (*conf_message_callback) (const char *fmt, va_list ap) =
+static void (*conf_message_callback)(const char *fmt, va_list ap) =
      conf_default_message_callback;
  void conf_set_message_callback(void (*fn) (const char *fmt, va_list ap))
  {
@@ -176,7 +176,7 @@ static int conf_set_sym_val(struct symbol *sym, int
def, int def_flags, char *p)
          /* fall through */
      case S_INT:
      case S_HEX:
-    done:
+done:
          if (sym_string_valid(sym, p)) {
              sym->def[def].val = xstrdup(p);
              sym->flags |= def_flags;
@@ -188,7 +188,7 @@ static int conf_set_sym_val(struct symbol *sym, int
def, int def_flags, char *p)
          }
          break;
      default:
-        ;
+        break;
      }
      return 0;
  }
@@ -198,6 +198,7 @@ static int add_byte(int c, char **lineptr, size_t slen,
size_t *n)
  {
      char *nline;
      size_t new_size = slen + 1;
+
      if (new_size > *n) {
          new_size += LINE_GROWTH - 1;
          new_size *= 2;
@@ -343,7 +344,7 @@ int conf_read_simple(const char *name, int def)
                  sym->flags |= def_flags;
                  break;
              default:
-                ;
+                break;
              }
          } else if (memcmp(line, CONFIG_, strlen(CONFIG_)) == 0) {
              p = strchr(line + strlen(CONFIG_), '=');
@@ -381,7 +382,9 @@ int conf_read_simple(const char *name, int def)
          }
  setsym:
          if (sym && sym_is_choice_value(sym)) {
-            struct symbol *cs = prop_get_symbol(sym_get_choice_prop(sym));
+            struct symbol *cs =
+                prop_get_symbol(sym_get_choice_prop(sym));
+
              switch (sym->def[def].tri) {
              case no:
                  break;
@@ -527,8 +530,7 @@ kconfig_print_comment(FILE *fp, const char *value, void
*arg)
      }
  }

-static struct conf_printer kconfig_printer_cb =
-{
+static struct conf_printer kconfig_printer_cb = {
      .print_symbol = kconfig_print_symbol,
      .print_comment = kconfig_print_comment,
  };
@@ -601,8 +603,7 @@ header_print_comment(FILE *fp, const char *value, void
*arg)
      fprintf(fp, " */\n");
  }

-static struct conf_printer header_printer_cb =
-{
+static struct conf_printer header_printer_cb = {
      .print_symbol = header_print_symbol,
      .print_comment = header_print_comment,
  };
@@ -613,15 +614,16 @@ static struct conf_printer header_printer_cb =
   * This printer is used when generating the `include/config/tristate.conf'
file.
   */
  static void
-tristate_print_symbol(FILE *fp, struct symbol *sym, const char *value,
void *arg)
+tristate_print_symbol(FILE *fp, struct symbol *sym,
+              const char *value, void *arg)
  {

      if (sym->type == S_TRISTATE && *value != 'n')
-        fprintf(fp, "%s%s=%c\n", CONFIG_, sym->name,
(char)toupper(*value));
+        fprintf(fp, "%s%s=%c\n",
+            CONFIG_, sym->name, (char)toupper(*value));
  }

-static struct conf_printer tristate_printer_cb =
-{
+static struct conf_printer tristate_printer_cb = {
      .print_symbol = tristate_print_symbol,
      .print_comment = kconfig_print_comment,
  };
@@ -680,8 +682,7 @@ int conf_write_defconfig(const char *filename)
      /* Traverse all menus to find all relevant symbols */
      menu = rootmenu.list;

-    while (menu != NULL)
-    {
+    while (menu != NULL) {
          sym = menu->sym;
          if (sym == NULL) {
              if (!menu_is_visible(menu))
@@ -695,7 +696,8 @@ int conf_write_defconfig(const char *filename)
              if (!sym_is_changable(sym))
                  goto next_menu;
              /* If symbol equals to default value - skip */
-            if (strcmp(sym_get_string_value(sym),
sym_get_string_default(sym)) == 0)
+            if (strcmp(sym_get_string_value(sym),
+                   sym_get_string_default(sym)) == 0)
                  goto next_menu;

              /*
@@ -722,8 +724,7 @@ int conf_write_defconfig(const char *filename)
  next_menu:
          if (menu->list != NULL) {
              menu = menu->list;
-        }
-        else if (menu->next != NULL) {
+        } else if (menu->next != NULL) {
              menu = menu->next;
          } else {
              while ((menu = menu->parent)) {
@@ -757,19 +758,24 @@ int conf_write(const char *name)
              strcpy(dirname, name);
              strcat(dirname, "/");
              basename = conf_get_configname();
-        } else if ((slash = strrchr(name, '/'))) {
-            int size = slash - name + 1;
-            memcpy(dirname, name, size);
-            dirname[size] = 0;
-            if (slash[1])
-                basename = slash + 1;
-            else
-                basename = conf_get_configname();
-        } else
-            basename = name;
-    } else
+        } else {
+            slash = strrchr(name, '/')
+            if (slash != NULL) {
+                int size = slash - name + 1;
+
+                memcpy(dirname, name, size);
+                dirname[size] = 0;
+                if (slash[1])
+                    basename = slash + 1;
+                else
+                    basename = conf_get_configname();
+            } else {
+                basename = name;
+            }
+        }
+    } else {
          basename = conf_get_configname();
-
+    }
      sprintf(newname, "%s%s", dirname, basename);
      env = getenv("KCONFIG_OVERWRITECONFIG");
      if (!env || !*env) {
@@ -814,12 +820,13 @@ int conf_write(const char *name)
          }
          if (menu->next)
              menu = menu->next;
-        else while ((menu = menu->parent)) {
-            if (menu->next) {
-                menu = menu->next;
-                break;
+        else
+            while ((menu = menu->parent)) {
+                if (menu->next) {
+                    menu = menu->next;
+                    break;
+                }
              }
-        }
      }
      fclose(out);

@@ -996,7 +1003,8 @@ int conf_write_autoconf(void)
          /* write symbol to auto.conf, tristate and header files */
          conf_write_symbol(out, sym, &kconfig_printer_cb, (void *)1);

-        conf_write_symbol(tristate, sym, &tristate_printer_cb, (void *)1);
+        conf_write_symbol(tristate, sym,
+                  &tristate_printer_cb, (void *)1);

          conf_write_symbol(out_h, sym, &header_printer_cb, NULL);
      }
@@ -1031,6 +1039,7 @@ static void (*conf_changed_callback)(void);
  void sym_set_change_count(int count)
  {
      int _sym_change_count = sym_change_count;
+
      sym_change_count = count;
      if (conf_changed_callback &&
          (bool)_sym_change_count != (bool)count)
@@ -1085,8 +1094,7 @@ static bool randomize_choice_values(struct symbol
*csym)
          if (def == cnt++) {
              sym->def[S_DEF_USER].tri = yes;
              csym->def[S_DEF_USER].val = sym;
-        }
-        else {
+        } else {
              sym->def[S_DEF_USER].tri = no;
          }
          sym->flags |= SYMBOL_DEF_USER;
@@ -1130,27 +1138,29 @@ bool conf_set_all_new_symbols(enum conf_def_mode
mode)

      pby = 50; pty = ptm = 33; /* can't go as the default in switch-case
                     * below, otherwise gcc whines about
-                   * -Wmaybe-uninitialized */
+                   * -Wmaybe-uninitialized
+                   */
      if (mode == def_random) {
          int n, p[3];
          char *env = getenv("KCONFIG_PROBABILITY");
+
          n = 0;
-        while( env && *env ) {
+        while (env && *env) {
              char *endp;
-            int tmp = strtol( env, &endp, 10 );
-            if( tmp >= 0 && tmp <= 100 ) {
+            int tmp = strtol(env, &endp, 10);
+
+            if (tmp >= 0 && tmp <= 100) {
                  p[n++] = tmp;
              } else {
                  errno = ERANGE;
-                perror( "KCONFIG_PROBABILITY" );
-                exit( 1 );
+                perror("KCONFIG_PROBABILITY");
+                exit(1);
              }
              env = (*endp == ':') ? endp+1 : endp;
-            if( n >=3 ) {
+            if (n >= 3)
                  break;
-            }
          }
-        switch( n ) {
+        switch (n) {
          case 1:
              pby = p[0]; ptm = pby/2; pty = pby-ptm;
              break;
@@ -1162,10 +1172,10 @@ bool conf_set_all_new_symbols(enum conf_def_mode
mode)
              break;
          }

-        if( pty+ptm > 100 ) {
+        if (pty+ptm > 100) {
              errno = ERANGE;
-            perror( "KCONFIG_PROBABILITY" );
-            exit( 1 );
+            perror("KCONFIG_PROBABILITY");
+            exit(1);
          }
      }
      bool has_changed = false;
-- 
2.17.0
