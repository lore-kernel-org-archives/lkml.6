Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbeCLXks (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:40:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37367 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeCLXkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:40:46 -0400
X-Google-Smtp-Source: AG47ELvH/5GuyxeWDFQu18T8OsUKIKjv+zPVAwp5kJ/EkZqq9v32XtHuZdp5kdAUSVo87tDljyiVLw==
Date: Tue, 13 Mar 2018 00:39:52 +0100
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: rdunlap@infradead.org, apw@canonical.com, joe@perches.com,
        corbet@lwn.net, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clang-format: add configuration file
Message-ID: <20180312233952.niz2cuz7psv4fe2s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-format is a tool to format C/C++/... code according to a set
of rules and heuristics. Like all tools, it is not perfect nor
covers every single case, but it is good enough to be helpful.

In particular, it is useful for quickly re-formatting blocks of code,
spotting coding style mistakes, sorting #includes, aligning variables/
comments/macro endings, reflowing text, etc. It also serves as
a teaching tool/guide for newcomers.

The tool itself has been already included in the repositories of popular
Linux distributions for a long time. The rules in this file are intended
for clang-format >= 4, which is easily available in most distributions.

This commit adds the configuration file that contains the rules that
the tool uses to know how to format the code according to the kernel
coding style. This gives us two advantages:

  * clang-format works out of the box with reasonable defaults;
    avoiding that everyone has to re-do the configuration.

  * Everyone agrees (eventually) on what is the most useful default
    configuration for most of the kernel.

Some of clang-format's features relevant for the kernel are:

  * Uses clang's tooling support behind the scenes to parse and rewrite
    the code. It is not based on ad-hoc regexps.

  * Supports reasonably well the Linux kernel coding style.

  * Fast enough to be used at the press of a key.

  * There are already integrations (either built-in or third-party)
    for many common editors used by kernel developers (e.g. vim,
    emacs, Sublime, Atom...) that allow you to format an entire file
    or, more usefully, just your selection.

  * Able to parse unified diffs -- you can, for instance, reformat
    only the lines changed by a git commit.

  * Able to reflow text comments as well.

  * Widely supported and used by hundreds of developers in highly
    complex projects and organizations (e.g. the LLVM project itself,
    Chromium, WebKit, Google, Mozilla...). Therefore, it should be
    supported for a long time.

See more information about the tool at:

    https://clang.llvm.org/docs/ClangFormat.html
    https://clang.llvm.org/docs/ClangFormatStyleOptions.html

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 .clang-format                          | 107 +++++++++++++++++++++++++++++++++
 .gitignore                             |   1 +
 Documentation/process/4.Coding.rst     |   6 ++
 Documentation/process/coding-style.rst |   6 ++
 4 files changed, 120 insertions(+)
 create mode 100644 .clang-format

diff --git a/.clang-format b/.clang-format
new file mode 100644
index 000000000000..de2e083be674
--- /dev/null
+++ b/.clang-format
@@ -0,0 +1,107 @@
+# Intended for clang-format >= 4
+---
+AccessModifierOffset: -4
+AlignAfterOpenBracket: DontAlign
+AlignConsecutiveAssignments: false
+AlignConsecutiveDeclarations: false
+#AlignEscapedNewlines: Left # Unknown to clang-format-4.0
+AlignOperands: false
+AlignTrailingComments: true
+AllowAllParametersOfDeclarationOnNextLine: true
+AllowShortBlocksOnASingleLine: false
+AllowShortCaseLabelsOnASingleLine: false
+AllowShortFunctionsOnASingleLine: None
+AllowShortIfStatementsOnASingleLine: false
+AllowShortLoopsOnASingleLine: false
+AlwaysBreakAfterDefinitionReturnType: None
+AlwaysBreakAfterReturnType: None
+AlwaysBreakBeforeMultilineStrings: false
+AlwaysBreakTemplateDeclarations: false
+BinPackArguments: true
+BinPackParameters: true
+BraceWrapping:
+  AfterClass: false
+  AfterControlStatement: false
+  AfterEnum: true
+  AfterFunction: true
+  AfterNamespace: true
+  AfterObjCDeclaration: false
+  AfterStruct: true
+  AfterUnion: true
+  #AfterExternBlock: true # Unknown to clang-format-5.0
+  BeforeCatch: false
+  BeforeElse: false
+  IndentBraces: false
+  #SplitEmptyFunction: true # Unknown to clang-format-4.0
+  #SplitEmptyRecord: true # Unknown to clang-format-4.0
+  #SplitEmptyNamespace: true # Unknown to clang-format-4.0
+BreakBeforeBinaryOperators: All
+BreakBeforeBraces: Custom
+#BreakBeforeInheritanceComma: false # Unknown to clang-format-4.0
+BreakBeforeTernaryOperators: true
+BreakConstructorInitializersBeforeComma: false
+#BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
+BreakAfterJavaFieldAnnotations: false
+BreakStringLiterals: true
+ColumnLimit: 80
+CommentPragmas: '^ IWYU pragma:'
+#CompactNamespaces: false # Unknown to clang-format-4.0
+ConstructorInitializerAllOnOneLineOrOnePerLine: false
+ConstructorInitializerIndentWidth: 8
+ContinuationIndentWidth: 8
+Cpp11BracedListStyle: false
+DerivePointerAlignment: false
+DisableFormat: false
+ExperimentalAutoDetectBinPacking: false
+#FixNamespaceComments: false # Unknown to clang-format-4.0
+ForEachMacros:
+#IncludeBlocks: Preserve # Unknown to clang-format-5.0
+IncludeCategories:
+  - Regex: '.*'
+    Priority: 1
+IncludeIsMainRegex: '(Test)?$'
+IndentCaseLabels: false
+#IndentPPDirectives: None # Unknown to clang-format-5.0
+IndentWidth: 8
+IndentWrappedFunctionNames: true
+JavaScriptQuotes: Leave
+JavaScriptWrapImports: true
+KeepEmptyLinesAtTheStartOfBlocks: false
+MacroBlockBegin: ''
+MacroBlockEnd: ''
+MaxEmptyLinesToKeep: 1
+NamespaceIndentation: Inner
+#ObjCBinPackProtocolList: Auto # Unknown to clang-format-5.0
+ObjCBlockIndentWidth: 8
+ObjCSpaceAfterProperty: true
+ObjCSpaceBeforeProtocolList: true
+#PenaltyBreakAssignment: 2 # Unknown to clang-format-4.0
+PenaltyBreakBeforeFirstCallParameter: 19
+PenaltyBreakComment: 300
+PenaltyBreakFirstLessLess: 120
+PenaltyBreakString: 1000
+PenaltyExcessCharacter: 1000000
+PenaltyReturnTypeOnItsOwnLine: 60
+PointerAlignment: Right
+ReflowComments: false
+SortIncludes: true
+#SortUsingDeclarations: true # Unknown to clang-format-4.0
+SpaceAfterCStyleCast: false
+SpaceAfterTemplateKeyword: true
+SpaceBeforeAssignmentOperators: true
+#SpaceBeforeCtorInitializerColon: true # Unknown to clang-format-5.0
+#SpaceBeforeInheritanceColon: true # Unknown to clang-format-5.0
+SpaceBeforeParens: ControlStatements
+#SpaceBeforeRangeBasedForLoopColon: true # Unknown to clang-format-5.0
+SpaceInEmptyParentheses: false
+SpacesBeforeTrailingComments: 1
+SpacesInAngles: false
+SpacesInContainerLiterals: false
+SpacesInCStyleCastParentheses: false
+SpacesInParentheses: false
+SpacesInSquareBrackets: false
+Standard: Cpp03
+TabWidth: 8
+UseTab: Always
+...
+
diff --git a/.gitignore b/.gitignore
index 1be78fd8163b..ab5cbc1e85f6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -81,6 +81,7 @@ modules.builtin
 !.gitignore
 !.mailmap
 !.cocciconfig
+!.clang-format
 
 #
 # Generated include files
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 26b106071364..d4bdbb17f2f5 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -58,6 +58,12 @@ can never be transgressed.  If there is a good reason to go against the
 style (a line which becomes far less readable if split to fit within the
 80-column limit, for example), just do it.
 
+Note that you can use the clang-format tool to help you with these rules
+and to quickly re-format parts of your code automatically. It is specially
+useful for new files/code and to spot coding style mistakes. It is also
+useful to sort #includes, to align variables or comments, to reflow text
+and other similar tasks.
+
 
 Abstraction layers
 ******************
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index a20b44a40ec4..ceac420cd9ec 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -622,6 +622,12 @@ options ``-kr -i8`` (stands for ``K&R, 8 character indents``), or use
 re-formatting you may want to take a look at the man page.  But
 remember: ``indent`` is not a fix for bad programming.
 
+Note that you can also use the clang-format tool to help you with these rules
+and to quickly re-format parts of your code automatically. It is specially
+useful for new files/code and to spot coding style mistakes. It is also
+useful to sort #includes, to align variables or comments, to reflow text
+and other similar tasks.
+
 
 10) Kconfig configuration files
 -------------------------------
-- 
2.14.1
